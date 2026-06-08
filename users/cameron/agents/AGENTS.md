## Code Editing Discipline

Expect all work to be done on stubs, or existing code, unless explicitly told otherwise. If new code outside of the code needed for stub completion is required, discuss it first.

Be concise in your explanations - focus on what's important rather than explaining obvious details.

### No Script-Based Changes

**NEVER** run a script that processes/changes code files in this repo. Brittle regex-based and Python transformations create far more problems than they solve.

- **Always make code changes manually**, even when there are many instances
- For many simple changes: use parallel subagents
- For subtle/complex changes: do them methodically yourself

### No File Proliferation

If you want to change something or add a feature, **revise existing code files in place**.

**NEVER** create variations like:

- `mainV2.go`
- `main_improved.go`
- `main_enhanced.go`

New files are reserved for **genuinely new functionality** that makes zero sense to include in any existing file. The bar for creating new files is **incredibly high**.

---

## Compiler Checks (CRITICAL)

**After any substantive code changes, you MUST verify no errors were introduced:**

If you see errors, **carefully understand and resolve each issue**. Read sufficient context to fix them the RIGHT way.

When fetching external documentation (library references, API specs, LLM context files, etc.), save a local copy to .copilot/docs/<library-name>.txt before using it. On subsequent uses, check .copilot/docs/ first and read from the cached copy instead of re-fetching. Only re-fetch if the cached copy is clearly stale or the user asks for a refresh.
