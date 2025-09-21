OVERVIEW-

Fake news spreads rapidly across social media and messaging platforms, making it hard for users to distinguish fact from misinformation.
The Floating News Verifier App acts as a floating verification button, allowing users to instantly check the authenticity of messages, posts, or screenshots without leaving the app they are using.

KEY FEATURES-

Real-Time Claim Verification : Instantly verify news or text using AI and trusted news sources.
OCR Support : Upload an image or screenshot — the app extracts the text automatically for verification.
Truth Score (0–100%) : Get a clear, percentage-based truth score with explanations.
Trusted Sources : View links to reliable articles supporting or refuting the claim.
Floating Button UI : Quick access to verification anytime, anywhere.
Cross-Platform Support : Works seamlessly on both Android and iOS.

APP WORKFLOW-
User clicks the floating button overlay.
App captures either text input or text extracted from images.
Sends data to the backend API (/verify-text or /verify-image).

BACKEND-
Fetches real-time news articles using GNews API.
Runs AI model to compare claim vs trusted sources.
Returns truth score, explanation, and sources.
User instantly sees verification results on the app.
