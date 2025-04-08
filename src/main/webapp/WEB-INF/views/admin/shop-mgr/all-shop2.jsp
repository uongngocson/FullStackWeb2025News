<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en" dir="ltr">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>Shops</title>
            <link rel="icon" type="image/x-icon" href="favicon.png">
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;500;600;700;800&display=swap"
                rel="stylesheet">
            <link rel="stylesheet" href="../../../../resources/assets2/css/perfect-scrollbar.min.css">
            <link rel="stylesheet" href="../../../../resources/assets2/css/style.css">
            <link rel="stylesheet" href="../../../../resources/assets2/css/animate.css" defer>
            <script src="../../../../resources/assets2/js/perfect-scrollbar.min.js"></script>
            <script src="../../../../resources/assets2/js/popper.min.js" defer></script>
            <script src="../../../../resources/assets2/js/tippy-bundle.umd.min.js" defer></script>
            <script src="../../../../resources/assets2/js/sweetalert.min.js" defer></script>
        </head>

        <body x-data="main" class="relative overflow-x-hidden font-nunito text-sm font-normal antialiased"
            :class="[$store.app.sidebar ? 'toggle-sidebar' : '', $store.app.theme === 'dark' || $store.app.isDarkMode ? 'dark' : '', $store.app.menu, $store.app.layout, $store.app.rtlClass]">
            <!-- Sidebar overlay -->
            <div x-cloak class="fixed inset-0 z-50 bg-black/60 lg:hidden" :class="{'hidden': !$store.app.sidebar}"
                @click="$store.app.toggleSidebar()"></div>

            <!-- Screen loader -->
            <jsp:include page="../layout/screen-loader.jsp" />

            <!-- Scroll to top button -->
            <jsp:include page="../layout/scroll-top.jsp" />

            <div class="main-container min-h-screen text-black dark:text-white-dark" :class="[$store.app.navbar]">
                <!-- Sidebar -->
                <jsp:include page="../layout/sidebar2.jsp" />

                <div class="main-content flex min-h-screen flex-col">
                    <!-- Header -->
                    <jsp:include page="../layout/header2.jsp" />

                    <div class="animate__animated p-6" :class="[$store.app.animation]">
                        <!-- start main content section -->
                        <div x-data="custom">
                            <div class="space-y-6">
                                <ul class="flex space-x-2 rtl:space-x-reverse">
                                    <li>
                                        <a href="javascript:;" class="text-primary hover:underline">Shops</a>
                                    </li>
                                    <li class="before:content-['/'] ltr:before:mr-1 rtl:before:ml-1">
                                        <span>List</span>
                                    </li>
                                </ul>

                                <div class="panel sticky-column sticky-header">
                                    <h5
                                        class="mb-5 text-lg font-semibold dark:text-white-light md:absolute md:top-[25px] md:mb-0">
                                        Shops List</h5>
                                    <table id="shopsTable"
                                        class="table-checkbox table-striped table-hover whitespace-nowrap"></table>
                                </div>
                            </div>
                        </div>
                        <!-- end main content section -->
                    </div>

                    <!-- Footer -->
                    <jsp:include page="../layout/footer2.jsp" />
                </div>
            </div>

            <!-- Scripts -->
            <script src="../../../../resources/assets2/js/alpine-collaspe.min.js"></script>
            <script src="../../../../resources/assets2/js/alpine-persist.min.js"></script>
            <script src="../../../../resources/assets2/js/alpine-ui.min.js" defer></script>
            <script src="../../../../resources/assets2/js/alpine-focus.min.js" defer></script>
            <script src="../../../../resources/assets2/js/alpine.min.js" defer></script>
            <script src="../../../../resources/assets2/js/custom.js"></script>
            <script src="../../../../resources/assets2/js/apexcharts.js" defer></script>
            <script src="../../../../resources/assets2/js/simple-datatables.js"></script>
            <script src="../../../../resources/assets2/js/highlight.min.js"></script>

            <script>
                document.addEventListener('alpine:init', () => {
                    Alpine.data('scrollToTop', () => ({
                        showTopButton: false,
                        init() {
                            window.onscroll = () => this.scrollFunction();
                        },
                        scrollFunction() {
                            this.showTopButton = document.body.scrollTop > 50 || document.documentElement.scrollTop > 50;
                        },
                        goToTop() {
                            document.body.scrollTop = 0;
                            document.documentElement.scrollTop = 0;
                        }
                    }));

                    // sidebar section
                    Alpine.data('sidebar', () => ({
                        init() {
                            const selector = document.querySelector('.sidebar ul a[href="' + window.location.pathname + '"]');
                            if (selector) {
                                selector.classList.add('active');
                                const ul = selector.closest('ul.sub-menu');
                                if (ul) {
                                    let ele = ul.closest('li.menu').querySelectorAll('.nav-link');
                                    if (ele) {
                                        ele = ele[0];
                                        setTimeout(() => {
                                            ele.click();
                                        });
                                    }
                                }
                            }
                        },
                    }));

                    // header section
                    Alpine.data('header', () => ({
                        init() {
                            const selector = document.querySelector('ul.horizontal-menu a[href="' + window.location.pathname + '"]');
                            if (selector) {
                                selector.classList.add('active');
                                const ul = selector.closest('ul.sub-menu');
                                if (ul) {
                                    let ele = ul.closest('li.menu').querySelectorAll('.nav-link');
                                    if (ele) {
                                        ele = ele[0];
                                        setTimeout(() => {
                                            ele.classList.add('active');
                                        });
                                    }
                                }
                            }
                        }
                    }));

                    Alpine.data('custom', () => ({
                        ids: [], // Mảng lưu ID các shop được chọn
                        datatable: null,
                        shopData: [
                            <c:forEach items="${shops}" var="shop" varStatus="loop">
                                [
                                ${shop.shopId},
                                '${loop.index + 1}',
                                '${shop.shopName}',
                                '${shop.shopAddress}',
                                '${shop.contactPerson}',
                                '${shop.operatingHours}',
                                '${shop.shopDescription}',
                                ''
                                ]${!loop.last ? ',' : ''}
                            </c:forEach>
                        ],

                        init() {
                            this.datatable = new simpleDatatables.DataTable('#shopsTable', {
                                data: {
                                    headings: [
                                        '<input type="checkbox" class="form-checkbox" id="checkAll" @change="checkAll($event.target.checked)" :checked="ids.length === shopData.length && shopData.length > 0"/>',
                                        'No.',
                                        'Shop Name',
                                        'Address',
                                        'Contact Person',
                                        'Operating Hours',
                                        'Description',
                                        'Action'
                                    ],
                                    data: this.shopData,
                                },
                                perPage: 10,
                                perPageSelect: [5, 10, 20, 30],
                                columns: [
                                    {
                                        select: 0,
                                        sortable: false,
                                        render: (data) => `
                        <input type="checkbox" 
                               class="form-checkbox row-checkbox" 
                               value="${data}" 
                               @change="updateIds($event.target)"
                               :checked="ids.includes(${data})"/>
                    `
                                    },
                                    {
                                        select: 7,
                                        sortable: false,
                                        render: () => `
                        <div class="flex items-center justify-center gap-2">
                            <a href="javascript:;" x-tooltip="Edit">✏️</a>
                            <a href="javascript:;" x-tooltip="Delete">❌</a>
                        </div>
                    `
                                    }
                                ],
                                layout: {
                                    top: '{search}',
                                    bottom: '{info}{select}{pager}'
                                }
                            });
                        },

                        // Chọn/bỏ chọn tất cả
                        checkAll(isChecked) {
                            this.ids = isChecked ? this.shopData.map(d => d[0]) : [];
                            this.updateCheckboxes();
                        },

                        // Cập nhật ID khi thay đổi checkbox từng dòng
                        updateIds(checkbox) {
                            const value = parseInt(checkbox.value);
                            if (checkbox.checked) {
                                if (!this.ids.includes(value)) {
                                    this.ids.push(value);
                                }
                            } else {
                                this.ids = this.ids.filter(id => id !== value);
                            }
                            this.updateHeaderCheckbox();
                        },

                        // Đồng bộ trạng thái checkbox header
                        updateHeaderCheckbox() {
                            const headerCheckbox = document.querySelector('#checkAll');
                            if (headerCheckbox) {
                                headerCheckbox.checked = this.ids.length === this.shopData.length && this.shopData.length > 0;
                                headerCheckbox.indeterminate = this.ids.length > 0 && this.ids.length < this.shopData.length;
                            }
                        },

                        // Cập nhật trạng thái visual của các checkbox
                        updateCheckboxes() {
                            document.querySelectorAll('.row-checkbox').forEach(checkbox => {
                                checkbox.checked = this.ids.includes(parseInt(checkbox.value));
                            });
                            this.updateHeaderCheckbox();
                        }
                    }));
                });
            </script>

            <style>
                table.table-checkbox thead tr th:first-child {
                    width: 1px !important;
                }
            </style>
        </body>

        </html>