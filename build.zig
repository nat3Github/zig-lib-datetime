const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const mod = b.addModule("datetime", .{
        .root_source_file = b.path("time.zig"),
        .target = target,
        .optimize = optimize,
    });

    const t = b.addTest(.{
        .root_source_file = b.path("test.zig"),
        .target = target,
        .optimize = optimize,
    });
    t.root_module.addImport("datetime", mod);

    const run_t = b.addRunArtifact(t);

    const t_step = b.step("test", "Run all library tests");
    t_step.dependOn(&run_t.step);
}
