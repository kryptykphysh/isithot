module.exports = {
  mode: 'jit',
  content: [
    './app/views/**/*.{slim,erb,jbuilder,turbo_stream,js}',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  daisyui: {
    styled: true,
    themes: ["fantasy", "halloween"],
    base: true,
    utils: true,
    logs: true,
    rtl: false,
    darkTheme: "halloween",
    prefix: '',
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('daisyui'),
  ]
}
