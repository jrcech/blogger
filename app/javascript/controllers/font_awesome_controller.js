import { Controller } from '@hotwired/stimulus';
import '@fortawesome/fontawesome-free/js/all';

// Connects to data-controller="font-awesome"
export default class extends Controller {
  connect() {
    console.log('fa')
    FontAwesome.config.mutateApproach = 'sync';
  }
}
