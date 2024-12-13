import { Controller } from "@hotwired/stimulus"

export default class SearchUser extends Controller {
    static targets = [
        "searchInput",
        "results",
        "selectedUserId"
    ]

    connect() {
        this.debounceTimer = null
    }

    search(event) {
        clearTimeout(this.debounceTimer)
        console.log(this.searchInputTarget.value)
        const query = this.searchInputTarget.value
        if (query.length >= 2) {
            this.debounceTimer = setTimeout(() => {
                this.fetchResults(query)
            }, 300)
        } else {
            this.clearResults()
        }
    }

    fetchResults(query) {
        const url = `/admin/users/search?query=${encodeURIComponent(query)}`

        fetch(url, {
            headers: {
                'Accept': 'text/vnd.turbo-stream.html'
            }
        })
            .then(response => response.text())
            .then(html => {
                this.resultsTarget.innerHTML = html
            })
            .catch(error => {
                console.error('Search error:', error)
                this.clearResults()
            })
    }

    selectUser(event) {
        event.preventDefault()

        const userId = event.currentTarget.dataset.userId
        const userName = event.currentTarget.dataset.userName

        this.selectedUserIdTarget.value = userId

        this.searchInputTarget.value = userName

        this.clearResults()
    }

    // Method to clear search results
    clearResults() {
        this.resultsTarget.innerHTML = ''
    }
}