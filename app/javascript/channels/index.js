// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

import "./notification"
import * as Futurism from '@minthesize/futurism'
import consumer from '../channels/consumer'
const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)
Futurism.initializeElements()
Futurism.createSubscription(consumer)
