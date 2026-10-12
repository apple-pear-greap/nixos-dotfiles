import base64
import contextlib
import io
import json
from pathlib import Path
import runpy
import tempfile
import unittest
from unittest.mock import patch

module = runpy.run_path(str(Path(__file__).resolve().parents[1] / "sb-chatgpt"))
format_usage = module["format_usage"]
main = module["main"]


class ChatGPTBlockTests(unittest.TestCase):
    def test_remaining_and_reset_countdown(self):
        data = {"windows": [
            {"seconds": 604800, "remaining": 20, "reset": 87400},
            {"seconds": 18000, "remaining": 88, "reset": 4600},
        ]}
        self.assertEqual(format_usage(data, now=1000), "Codex 5h:88%@1h00m 7d:20%@1d0h")

    def test_elapsed_reset_does_not_invent_new_allowance(self):
        data = {"windows": [{"seconds": 18000, "remaining": 0, "reset": 1000}]}
        self.assertEqual(format_usage(data, now=1001), "Codex 5h:0%@pending")

    def test_account_claim(self):
        claim = {"https://api.openai.com/auth": {"chatgpt_account_id": "test-account"}}
        payload = base64.urlsafe_b64encode(json.dumps(claim).encode()).decode().rstrip("=")
        self.assertEqual(module["jwt_account"]("header." + payload + ".sig"), "test-account")
        self.assertIsNone(module["jwt_account"]("invalid"))

    def test_cache_and_offline_fallback(self):
        data = {"fetched": 1000, "windows": [
            {"seconds": 18000, "remaining": 88, "reset": 4600},
        ]}
        with tempfile.TemporaryDirectory() as directory:
            with patch.dict("os.environ", {"XDG_CACHE_HOME": directory}), \
                    patch("sys.argv", ["sb-chatgpt"]), \
                    patch.dict(main.__globals__, {"credentials": lambda: ("secret", None)}), \
                    patch("time.time", return_value=1000), \
                    patch.dict(main.__globals__, {"fetch_usage": lambda *args: data}):
                output = io.StringIO()
                with contextlib.redirect_stdout(output):
                    main()
                self.assertIn("88%", output.getvalue())
                cache = Path(directory) / "sb-chatgpt/usage.json"
                self.assertNotIn("secret", cache.read_text())
                self.assertEqual(cache.stat().st_mode & 0o777, 0o600)
                # A cached call must not perform a network request.
                with patch.dict(main.__globals__, {"fetch_usage": lambda *args: self.fail("uncached request")}):
                    with contextlib.redirect_stdout(io.StringIO()):
                        main()
                with patch("time.time", return_value=1400), \
                        patch.dict(main.__globals__, {"fetch_usage": lambda *args: (_ for _ in ()).throw(OSError())}):
                    output = io.StringIO()
                    with contextlib.redirect_stdout(output):
                        main()
                    self.assertIn("[offline]", output.getvalue())
                    self.assertIn("88%", output.getvalue())


if __name__ == "__main__":
    unittest.main()
