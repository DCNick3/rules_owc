

def owc_compile_action(ctx, sources, platform, exe):
    tool = ctx.executable._owcc_wrapper
    owc_dir = ctx.file._owc_dir
    
    ctx.actions.run(
            inputs = sources + ctx.files._owc_all,
            outputs = [exe],
            arguments = [owc_dir.path, platform, exe.path] + [ x.path for x in sources ],
            executable = tool,
            
            mnemonic = "OwcCompile",
            progress_message = "Compiling %s with owc" % exe.short_path,
        )

def _owc_binary_impl(ctx):
    exe = ctx.actions.declare_file(ctx.label.name)

    owc_compile_action(ctx, ctx.files.srcs, ctx.attr.platform, exe)
    
    return [
        DefaultInfo(files = depset([exe]))
    ]

owc_binary = rule(
    implementation = _owc_binary_impl,
    attrs = {
        "srcs": attr.label_list(mandatory=True, allow_files=True),
        "platform": attr.string(values=['win95'], default='win95'),
        "_owcc_wrapper": attr.label(
            executable = True,
            cfg = "exec",
            allow_files = True,
            default = Label("//owc/private/wrappers:owcc_wrapper"),
        ),
        "_owc_dir": attr.label(
            default = Label("@open_watcom_v2_bin//:."),
            allow_single_file = True,
        ),
        "_owc_all": attr.label(
            default = Label("@open_watcom_v2_bin//:all"),
            allow_files = True,
        ),
    },
)
