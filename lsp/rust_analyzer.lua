-- Rust.  rust-analyzer needs a Cargo.toml (or rust-project.json for
-- non-cargo builds); a loose .rs file gets no analysis at all.

return {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", "rust-project.json" },
}
