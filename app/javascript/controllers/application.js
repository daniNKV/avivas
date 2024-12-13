import { Application } from "@hotwired/stimulus"
import PasswordVisibility from '@stimulus-components/password-visibility'
import RevealController from '@stimulus-components/reveal'
import RailsNestedForm from '@stimulus-components/rails-nested-form'
import Notification from '@stimulus-components/notification'
import SearchUser from "controllers/search_user";
import SearchProducts from 'controllers/search_products'
const application = Application.start()

application.register('password-visibility', PasswordVisibility)
application.register('notification', Notification)
application.register('reveal', RevealController)
application.register('nested-form', RailsNestedForm)
application.register('notification', Notification)
application.register('search-user', SearchUser)
application.register('search-products', SearchProducts)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
