# Antigravity RTL & BiDi Fix (مُحسّن الاتجاه للغات من اليمين إلى اليسار)

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Platform: Antigravity](https://img.shields.io/badge/Platform-Google%20Antigravity-orange.svg)](https://antigravity.google)
[![Languages: Arabic | Hebrew | Persian | Urdu](https://img.shields.io/badge/Languages-AR%20%7C%20HE%20%7C%20FA%20%7C%20UR-green.svg)](#)

> **A native, zero-dependency BiDi rendering protocol for Google Antigravity Desktop & CLI.**  
> Automatically fixes reversed text, flipped parentheses, misplaced punctuation, and broken inline Latin terms in Arabic, Hebrew, Persian, and Urdu.

---

## 📌 المشكلة (The Problem)

تطبيق **Google Antigravity Desktop** (المبني على Electron) مضبوط افتراضياً بتنسيق حاوية ثابت:
```css
direction: ltr !important;
text-align: left !important;
```
عندما يكتب الوكيل باللغة العربية مع إدراج مصطلحات إنجليزية تقنية (مثل: `TradingView`, `CDP API`, أو كتل الأكواد البرمجية):
1. تنقلب الأقواس وعلامات الترقيم (`:`, `.`, `?`).
2. تتبعثر الفقرات وتنعكس جملة الشرح وتُدفع الجمل بالكامل إلى أقصى اليسار.
3. تفشل إضافات المتصفح الخارجية لأن التطبيق مكتبي ومحمي، وتعطيل DevTools يمنع تعديل التنسيقات يدوياً.

---

## 💡 الحل الهندسي (The Solution)

يعتمد هذا المشروع على ميزة أساسية في محرك معالجة النصوص الخاص بـ Antigravity: **دعمه الداخلي لقراءة وسوم HTML الصريحة**.

من خلال إضافة قاعدة تشغيلية عامة (Global Agent Rule)، يتم توجيه الوكيل آلياً للقيام بما يلي:
* **عند الرد بالعربية أو اللغات ثنائية الاتجاه (RTL):** تغليف النص في وسم صريح:
  ```html
  <div dir="rtl" style="direction: rtl; text-align: right;">
  ... المحتوى العربي مع المصطلحات الإنجليزية في مكانها الدقيق ...
  </div>
  ```
* **عند الرد بالإنجليزية (LTR Auto-Switch):** إلغاء التغليف تلقائياً ليعود النص والكتل البرمجية إلى النسق اللاتيني الطبيعي من اليسار لليمين.

---

## 🚀 التثبيت السريع (Quick Installation)

### الخيار 1: عبر سطر الأوامر (تثبيت تلقائي بضغطة زر)

#### نظام Windows (PowerShell):
```powershell
irm https://raw.githubusercontent.com/your-username/antigravity-rtl/main/install.ps1 | iex
```
*أو محلياً:*
```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1
```

#### نظام macOS / Linux (Bash):
```bash
curl -fsSL https://raw.githubusercontent.com/your-username/antigravity-rtl/main/install.sh | bash
```

---

### الخيار 2: التثبيت اليدوي (Manual Setup)

1. افتح أو أنشئ ملف القواعد العام الخاص بـ Antigravity في جهازك:
   * **Windows:** `%USERPROFILE%\.gemini\config\plugins\omar-global-skills\rules\AGENTS.md` (أو داخل أي قاعدة نشطة في مجلد `.gemini\config\`).
   * **macOS / Linux:** `~/.gemini/config/rules/AGENTS.md`
   * **أو داخل أي مشروع محدد:** `.agents/rules/rtl.md`
2. أضف البروتوكول التالي إلى الملف:

```markdown
## Dynamic BiDi Rendering & RTL Protocol

- **Language Allocation**:
  - Arabic (or any RTL language: Hebrew, Persian, Urdu) for explanations, trade-offs, and conceptual dialogue.
  - English for all source code, identifiers, function signatures, comments, and technical symbols.

- **Dynamic Text Direction (RTL / LTR Auto-Switching)**:
  - **When communicating in RTL (Arabic/Hebrew/Persian/Urdu)**:
    Wrap the entire response inside:
    `<div dir="rtl" style="direction: rtl; text-align: right;">`
    `...`
    `</div>`
    This ensures proper line-starts from right-to-left, correct punctuation placement, and prevents inline Latin/English terms from scrambling the sentence structure.
  - **When communicating in LTR (English/French/etc.)**:
    Output standard Markdown without the RTL wrapper, allowing natural left-to-right flow.
```

3. احفظ الملف، وسيبدأ Antigravity بتطبيقه فوراً في كل محادثة جديدة!

---

## 📊 مقارنة قبل وبعد (Before & After)

| بدون الحل (Before Fix) ❌ | مع تطبيق البروتوكول (After Fix) ✅ |
| :--- | :--- |
| النص محاذى لليسار، الأقواس مقلوبة، والمصطلحات الإنجليزية تسبق الكلمات العربية. | النص محاذى لليمين بانسيابية تامة، والأقواس والمصطلحات في مكانها الصحيح. |
| `نفس التقنية المستخدمة في فحص صفحات) CDP (: يتم تشغيل 1.` | `1. يتم تشغيل تقنية CDP (المستخدمة في فحص الصفحات) بنجاح.` |

---

## ✍️ حل مشكلة صندوق ورسائل المستخدم (User Input & Bubble Fix)

إذا لاحظت أن رسالتك التي تكتبها في صندوق المحادثة تلتف بشكل خاطئ عند إدراج مصطلح إنجليزي (مثل انتقال الكلمة الإنجليزية لبداية السطر):

### 1. اختصار ويندوز لتغيير اتجاه حقل الإدخال:
أثناء وقوف المؤشر داخل صندوق الكتابة في Antigravity، اضغط على:
```text
Ctrl + Right Shift (الكنترول + الشفت الأيمن)
```
يقوم هذا الاختصار بتحويل اتجاه الكتابة في حقل الإدخال فوراً إلى RTL من اليمين لليسار.

### 2. القاعدة الذهبية عند إدخال المصطلحات الإنجليزية في سؤالك:
* **استخدم علامات الـ Backticks:** ضع الكلمة الإنجليزية بين علامتي \`...\` مثل: \`GitHub\` أو \`API\`. هذا يمنع خوارزمية المتصفح من تشتيت السطر العربي عند الالتفاف (Line Wrapping).
* **فصل المصطلحات في نهاية السطر:** عند كتابة أسئلة طويلة، اجعل الكلمات الإنجليزية في سطر مستقل أو في نهاية الجملة.

---

## 🤝 المساهمة (Contributing)

نرحب بأي تحسينات تدعم لغات إضافية أو تدعم قوالب مخصصة داخل Antigravity. الرجاء مراجعة [CONTRIBUTING.md](CONTRIBUTING.md).

## 📄 الترخيص (License)

هذا المشروع مرخص تحت رخصة [MIT License](LICENSE).
