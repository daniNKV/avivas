import { Application } from "@hotwired/stimulus"
import PasswordVisibility from '@stimulus-components/password-visibility'
import Notification from '@stimulus-components/notification'
import RevealController from '@stimulus-components/reveal'
import RailsNestedForm from '@stimulus-components/rails-nested-form'

const application = Application.start()

application.register('password-visibility', PasswordVisibility)
application.register('notification', Notification)
application.register('reveal', RevealController)
application.register('nested-form', RailsNestedForm)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
