import { Controller } from '@hotwired/stimulus';
import '@fortawesome/fontawesome-free/js/all';

export default class extends Controller {
  connect() {
    console.log(FontAwesome)
    console.log('cc')
    FontAwesome.config.mutateApproach = 'sync';
  }
}
