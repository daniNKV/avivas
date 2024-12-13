import { Controller } from "@hotwired/stimulus"

export default class SearchProducts extends Controller {
    static targets = [
        "searchInput",     // Input for searching products
        "results",         // Container for search results
        "selectedProducts" // Hidden input to track selected product IDs
    ]

    static values = {
        selectedIds: Array  // Tracks currently selected product IDs
    }

    connect() {
        this.debounceTimer = null
        // Initialize selected IDs if not already set
        if (!this.hasSelectedProductsValue) {
            this.selectedProductsValue = []
        }
    }

    search(event) {
        clearTimeout(this.debounceTimer)
        const query = this.searchInputTarget.value

        if (query.length >= 2) {
            this.debounceTimer = setTimeout(() => {
                this.fetchProducts(query)
            }, 300)
        } else {
            this.clearResults()
        }
    }

    fetchProducts(query) {
        const url = `/admin/products/search?query=${encodeURIComponent(query)}`

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
                console.error('Product search error:', error)
                this.clearResults()
            })
    }

    // Select a product
    selectProduct(event) {
        event.preventDefault()
        const productEl = event.currentTarget
        const productId = productEl.dataset.productId
        const productName = productEl.dataset.productName
        const productStock = productEl.dataset.productStock
        const productPrice = parseFloat(productEl.dataset.productPrice)

        // Prevent duplicate selections
        if (!this.selectedProductsValue.includes(productId)) {
            this.selectedProductsValue = [...this.selectedProductsValue, productId]
            this.renderSelectedProduct(productId, productName, productPrice, productStock)
        }

        // Clear search input and results
        this.searchInputTarget.value = ''
        this.clearResults()
    }

    renderSelectedProduct(id, name, price, stock) {
        const selectedContainer = document.getElementById('selected-products')
        if (!selectedContainer) {
            console.error('Selected products container not found')
            return
        }
        const productRow = document.createElement('div')
        productRow.classList.add(
            'flex', 'justify-between', 'items-center', 'p-2',
            'border-b', 'last:border-b-0', 'border-b-1', 'product-row'
        )
        productRow.innerHTML = `
          <div class="flex-grow">
            <span class="font-medium product-name">${name}</span>
            <input 
              type="number" 
              name="invoice[items_attributes][${id}][units]" 
              value="1" 
              min="1" 
              class="input input-bordered ml-2 w-20 product-quantity"
              data-product-id="${id}"
              data-action="change->search-products#updateTotalPrice"
            >
          </div>
          <div class="flex items-center">
            <span class="text-gray-500 text-sm"></span>
            <span class="text-gray-500 text-sm">Stock: ${stock}</span>
            <span class="mr-2 product-price">$${price.toFixed(2)}</span>
            <button 
              type="button"
              class="btn btn-xs btn-circle btn-outline remove-product" 
              data-action="click->search-products#removeProduct"
              data-product-id="${id}"
            >
              ✕
            </button>
          </div>
        `

        selectedContainer.appendChild(productRow)
        this.updateTotalPrice()
    }

    removeProduct(event) {
        const productId = event.currentTarget.dataset.productId
        this.selectedProductsValue = this.selectedProductsValue.filter(
            selectedId => selectedId.toString() !== productId.toString()
        )
        const productRow = event.currentTarget.closest('.product-row')
        if (productRow) {
            productRow.remove()
        }

        this.updateTotalPrice()
    }

    updateTotalPrice() {
        const totalPriceEl = document.getElementById('invoice-total-price')
        let total = 0

        document.querySelectorAll('#selected-products > .product-row').forEach(productRow => {
            const priceEl = productRow.querySelector('.product-price')
            const quantityInput = productRow.querySelector('.product-quantity')
            if (!priceEl || !quantityInput) {
                console.error('Price or quantity element not found', productRow)
                return
            }

            const price = parseFloat(
                priceEl.textContent.replace('$', '').trim()
            )
            const quantity = parseInt(quantityInput.value, 10)

            if (!isNaN(price) && !isNaN(quantity)) {
                total += price * quantity
            } else {
                console.warn('Invalid price or quantity', { price, quantity })
            }
        })

        if (totalPriceEl) {
            totalPriceEl.textContent = `$${total.toFixed(2)}`
        }

        const totalPriceInput = document.getElementById('invoice-total-price')
        if (totalPriceInput) {
            totalPriceInput.value = total.toFixed(2)
        }
    }
    // Clear search results
    clearResults() {
        this.resultsTarget.innerHTML = ''
    }
}