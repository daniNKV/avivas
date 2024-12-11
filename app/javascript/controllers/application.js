import { Application } from "@hotwired/stimulus"
import PasswordVisibility from '@stimulus-components/password-visibility'
import RevealController from '@stimulus-components/reveal'
import RailsNestedForm from '@stimulus-components/rails-nested-form'
import Notification from '@stimulus-components/notification'

const application = Application.start()

application.register('password-visibility', PasswordVisibility)
application.register('notification', Notification)
application.register('reveal', RevealController)
application.register('nested-form', RailsNestedForm)
application.register('notification', Notification)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
