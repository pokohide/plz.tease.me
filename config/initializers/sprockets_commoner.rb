Rails.application.config.assets.configure do |env|
  Sprockets::Commoner::Processor.configure(env,
    include: ['node_modules', 'app/assets/javascripts'],
    exclude: ['vendor/bundle', 'vendor/assets'],
    babel_exclude: [/node_modules/, 'vendor/assets']
  )
end
