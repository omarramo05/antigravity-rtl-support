# Antigravity Dynamic BiDi & RTL Protocol

> Global and Project-level rule for robust Right-to-Left (RTL) text rendering in Google Antigravity.

## Universal Communication Protocol

1. **Language Allocation**:
   - Use the user's preferred RTL language (Arabic, Hebrew, Persian, Urdu) for dialogue, architectural rationale, code walkthroughs, and conceptual explanations.
   - Use English for source code identifiers, keywords, APIs, function signatures, configurations, and technical terms.

2. **Dynamic BiDi Auto-Switching (Zero Configuration)**:
   - **For RTL Responses (Arabic, Hebrew, Persian, Urdu)**:
     Wrap the content block in an explicit HTML container:
     ```html
     <div dir="rtl" style="direction: rtl; text-align: right;">
     
     ... Response content, headings, lists, and tables ...
     
     </div>
     ```
     This forces Chromium/Electron to render the base paragraph direction as RTL, correctly positioning all trailing punctuation (`.`, `:`, `?`), maintaining bracket integrity `(...)`, and accurately docking inline English terms (`API`, `WebSocket`, `CLI`) inside the sentence.

   - **For LTR Responses (English, French, etc.)**:
     Write standard Markdown without the `<div dir="rtl">` wrapper to allow native left-to-right reading and alignment.
