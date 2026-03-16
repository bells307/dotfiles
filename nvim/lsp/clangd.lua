return {
	cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
	root_dir = vim.fs.dirname(
		vim.fs.find({ "compile_commands.json", "compile_flags.txt", ".git", "CMakeLists.txt" }, { upward = true })[1]
	),
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
}
