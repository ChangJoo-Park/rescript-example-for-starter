/** @type {import("snowpack").SnowpackUserConfig } */
module.exports = {
  mount: {
    public: { url: '/', static: true },
    src: { url: '/dist' },
  },
  exclude: ["**/*.{res,resi}"],
  plugins: [
    '@snowpack/plugin-react-refresh',
    '@snowpack/plugin-dotenv',
    '@jihchi/plugin-rescript',
    '@snowpack/plugin-postcss',
  ],
  packageOptions: {
    /* ... */
  },
  devOptions: {
    tailwindConfig: './tailwindcss.config.js'
  },
  buildOptions: {
    /* ... */
  },
  alias: {
    /* ... */
  },
};
