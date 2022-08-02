{ pkgs }: {
	deps = [
        pkgs.redis
        pkgs.sudo
        pkgs.nodejs-16_x
        pkgs.yarn
        pkgs.ruby_3_0
        pkgs.rubyPackages_3_0.solargraph
        pkgs.rufo
        pkgs.sqlite
	];
}