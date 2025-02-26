import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

// https://astro.build/config
export default defineConfig({
	integrations: [
		starlight({
			title: 'NixDots on NixOS',
			customCss: [
				'./src/styles/custom.css',
			],
			defaultLocale: 'root',
			locales: {
				root: {
					label: 'English',
					lang: 'en',
				},
				ja: {
					label: '日本語',
				},
			},
			social: {
				github: 'https://github.com/brklntmhwk/nixdots-on-nixos',
			},
			sidebar: [
				{
					label: 'Preface',
					translations: {
						ja: '序文',
					},
					items: [
						{
							label: 'Preface',
							slug: 'preface',
							translations: {
								ja: '序文',
							},
						},
					],
				},
				{
					label: 'Reference',
					translations: {
						ja: 'リファレンス',
					},
					autogenerate: { directory: 'reference' },
				},
			],
		}),
	],
});
