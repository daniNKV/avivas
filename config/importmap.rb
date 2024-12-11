# Pin npm packages by running ./bin/importmap

pin "application"
pin "stimulus-use" # @0.52.2
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "@stimulus-components/password-visibility", to: "@stimulus-components--password-visibility.js" # @3.0.0
pin "@stimulus-components/notification", to: "@stimulus-components--notification.js" # @3.0.0
pin "@stimulus-components/reveal", to: "@stimulus-components--reveal.js" # @5.0.0
pin "@stimulus-components/rails-nested-form", to: "@stimulus-components--rails-nested-form.js" # @5.0.0
pin_all_from "app/javascript/controllers", under: "controllers"
pin "theme-change" # @2.5.0
pin "theme", to: "theme.js"


