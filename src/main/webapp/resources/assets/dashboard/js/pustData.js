const products = [
    { id: 1, name: "Laptop", category: "Electronics", technology: "Intel i7", description: "High-performance laptop", price: "$1200", discount: "10%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 3, name: "Headphones", category: "Accessories", technology: "Bluetooth", description: "Noise-cancelling headphones", price: "$200", discount: "15%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },


];

function renderProducts() {
    const tbody = document.querySelector("tbody");
    tbody.innerHTML = ""; // Xóa dữ liệu cũ


    products.forEach(product => {
        const row = document.createElement("tr");
        row.className = "table-hover";

        row.innerHTML = `
            <td class="p-3 text-center">
                <div class="form-check">
                    <input id="checkbox-${product.id}" type="checkbox" class="form-check-input">
                    <label for="checkbox-${product.id}" class="form-check-label sr-only">Checkbox</label>
                </div>
            </td>
                        <td class="p-3 fw-medium">#${product.id}</td>

            
            <td class="p-3">
            
                <div class="fw-bold">${product.name}</div>
                <div class="text-muted">${product.category}</div>
            </td>
            <td class="p-3 fw-medium">${product.technology}</td>
            <td class="p-3 text-truncate" style="max-width: 250px;">${product.description}</td>
            <td class="p-3 fw-medium">${product.price}</td>
            <td class="p-3 fw-medium">${product.discount}</td>
            <td class="p-3">
               <button id="createProductButton" class="btn btn-primary" type="button"
                                        data-bs-toggle="offcanvas" data-bs-target="#drawerUpdateProduct"
                                        aria-controls="drawerUpdateProduct">
                                       <i class="bi bi-pencil-square"></i>  Update
                                    </button>
                                    <button id="createProductButton" class="btn btn-danger" type="button"
                                        data-bs-toggle="offcanvas" data-bs-target="#drawerDeleteProduct"
                                        aria-controls="drawerDeleteProduct">
                                      <i class="bi bi-trash"></i>  Delete
                                    </button>
                                       <button id="createProductButton" class="btn btn-danger  " type="button"
                                        data-bs-toggle="offcanvas" data-bs-target="#drawerDeleteProduct"
                                        aria-controls="drawerDeleteProduct">
                                      <i class="bi bi-trash"></i>  Delete
                                    </button>
               
                
            </td>
        `;

        tbody.appendChild(row);
    });
}

document.addEventListener("DOMContentLoaded", renderProducts);
