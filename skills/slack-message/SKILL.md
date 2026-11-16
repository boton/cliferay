---

description: Draft a Slack message and copy it to the clipboard in the format Slack converts on paste. Use when the user asks to draft, write, shorten, or copy a message, announcement, or update for Slack.
name: slack-message

---

# Slack Message

Draft a message for Slack, iterate on it with the user, and put it on the clipboard so that it pastes with working bold, code, and links.

## Draft

- Know the audience, and link only to what they can open.
- Keep it short.
- Lead each part with a bold label.
- Use real, verified numbers, the good and the bad.
- Include at least one piece of evidence the reader can open, linked with short text.

## Format

Slack takes the plain text from the clipboard and converts Markdown on paste. Write the clipboard text in this form:

| Element | Write | Do not write |
| --- | --- | --- |
| Bold | `**text**` | `*text*`, which pastes as italic |
| Inline code | `` `text` `` | |
| Link with custom text | `[text](https://example.com)` | A bare URL after the text |
| Paragraphs | One blank line between them | Headings (`#`), which Slack does not render |
| Lists | `- item` or `1. item` | Nested lists |

Do not put `text/html` on the clipboard, since Slack ignores it or pastes nothing.

## Copy

Write the final message to a file in the scratchpad directory, then run `copy.sh` from this skill's base directory, the directory that holds this file:

```bash
<skill-base-directory>/copy.sh <message-file>
```

It reads the clipboard back to confirm the copy. Copy only when the user asks, and repeat the message in a fenced block as a fallback.
