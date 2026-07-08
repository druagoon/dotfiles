# Output Scratchpad Directory

IMPORTANT: Default to this scratchpad directory for temporary files instead of `/tmp` or other system temp directories: `.local/draft`

Use this directory for temporary file needs when the tool or workflow allows it:

- Storing intermediate results or data during multi-step tasks
- Writing temporary scripts or configuration files
- Saving outputs that don't belong in the user's project
- Creating working files during analysis or processing
- Any file that would otherwise go to `/tmp`

Only use another temp directory when the user explicitly requests it, a tool requires it, or the location is not configurable.

The scratchpad directory is session-specific, isolated from the user's project, and can be used freely without permission prompts.
Creating or modifying files under `.local/draft` never requires confirmation and is exempt from the Change Safety policy.
