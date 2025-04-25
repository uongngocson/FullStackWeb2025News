document.addEventListener('DOMContentLoaded', function () {
    const sameAsShippingCheckbox = document.getElementById('sameAsShipping');
    if (sameAsShippingCheckbox) {
        sameAsShippingCheckbox.addEventListener('change', function() {
            const billingFields = document.getElementById('billingFields');
            if (billingFields) {
                if (this.checked) {
                    billingFields.classList.add('hidden');
                } else {
                    billingFields.classList.remove('hidden');
                }
            }
        });
    }

    const paymentMethods = document.querySelectorAll('.payment-method');
    paymentMethods.forEach(method => {
        method.addEventListener('click', function() {
            paymentMethods.forEach(m => {
                m.classList.remove('selected');
                const icon = m.querySelector('.w-4.h-4');
                if (icon) {
                    icon.classList.remove('bg-black');
                    icon.classList.add('bg-transparent');
                }
            });

            this.classList.add('selected');
            const icon = this.querySelector('.w-4.h-4');
            if (icon) {
                icon.classList.remove('bg-transparent');
                icon.classList.add('bg-black');
            }
        });
    });

    const cardNumberInput = document.getElementById('cardNumber');
    if (cardNumberInput) {
        cardNumberInput.addEventListener('input', function(e) {
            let value = this.value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');
            let match = value.substring(0, 16);
            let parts = [];
            for (let i = 0; i < match.length; i += 4) {
                parts.push(match.substring(i, i + 4));
            }
            this.value = parts.join(' ');
        });
    }

    const expiryInput = document.getElementById('expiry');
    if (expiryInput) {
        expiryInput.addEventListener('input', function(e) {
            let value = this.value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');
            if (value.length > 2) {
                this.value = value.substring(0, 2) + '/' + value.substring(2, 4);
            }
        });
    }
});
