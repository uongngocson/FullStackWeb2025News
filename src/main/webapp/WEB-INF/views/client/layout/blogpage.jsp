<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta http-equiv="X-UA-Compatible" content="IE=edge">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Document</title>
                    <script src="https://cdn.tailwindcss.com"></script>

                    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link rel="stylesheet" href="../../../../resources/assets/client/css/sontest.css">
                    <link
                        href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap"
                        rel="stylesheet">
                    <!-- <link rel="stylesheet"
                        href="${pageContext.request.contextPath}/resources/assets/client/css/style.css"> -->

                        <link rel="icon" href="https://image.similarpng.com/file/similarpng/very-thumbnail/2021/01/Fashion-shop-logo-design-on-transparent-background-PNG.png" type="image/x-icon">


                </head>



                <body>
                    <jsp:include page="navbar.jsp" />


                    <div class="relative p-4">
                        <div class="max-w-3xl mx-auto">
                            <div
                                class="mt-3 bg-white rounded-b lg:rounded-b-none lg:rounded-r flex flex-col justify-between leading-normal">
                                <div class="">

                                    <a href="#"
                                        class="text-indigo-600 hover:text-gray-700 transition duration-500 ease-in-out text-sm">
                                        Election
                                    </a>
                                    <h1 href="#" class="text-gray-900 font-bold text-4xl">Portrait Photography In Early
                                        Days</h1>
                                    <div class="py-5 text-sm font-regular text-gray-900 flex">
                                        <span class="mr-3 flex flex-row items-center">
                                            <svg class="text-indigo-600" fill="currentColor" height="13px" width="13px"
                                                version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg"
                                                xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                                                viewBox="0 0 512 512" style="enable-background:new 0 0 512 512;"
                                                xml:space="preserve">
                                                <g>
                                                    <g>
                                                        <path
                                                            d="M256,0C114.837,0,0,114.837,0,256s114.837,256,256,256s256-114.837,256-256S397.163,0,256,0z M277.333,256
                                c0,11.797-9.536,21.333-21.333,21.333h-85.333c-11.797,0-21.333-9.536-21.333-21.333s9.536-21.333,21.333-21.333h64v-128
                                                   c0-11.797,9.536-21.333,21.333-21.333s21.333,9.536,21.333,21.333V256z">
                                                        </path>
                                                    </g>
                                                </g>
                                            </svg>
                                            <span class="ml-1">6 mins ago</span>
                                        </span>

                                        <a href="#" class="flex flex-row items-center hover:text-indigo-600  mr-3">
                                            <svg class="text-indigo-600" fill="currentColor" height="16px"
                                                aria-hidden="true" role="img" focusable="false" viewBox="0 0 24 24"
                                                xmlns="http://www.w3.org/2000/svg">
                                                <path fill="currentColor"
                                                    d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z">
                                                </path>
                                                <path d="M0 0h24v24H0z" fill="none"></path>
                                            </svg>
                                            <span class="ml-1">AliSher Azimi</span></a>

                                        <a href="#" class="flex flex-row items-center hover:text-indigo-600">
                                            <svg class="text-indigo-600" fill="currentColor" height="16px"
                                                aria-hidden="true" role="img" focusable="false"
                                                xmlns="http://www.w3.org/2000/svg" viewBox="0 0 18 18">
                                                <path fill=""
                                                    d="M15.4496399,8.42490555 L8.66109799,1.63636364 L1.63636364,1.63636364 L1.63636364,8.66081885 L8.42522727,15.44178 C8.57869221,15.5954158 8.78693789,15.6817418 9.00409091,15.6817418 C9.22124393,15.6817418 9.42948961,15.5954158 9.58327627,15.4414581 L15.4486339,9.57610048 C15.7651495,9.25692435 15.7649133,8.74206554 15.4496399,8.42490555 Z M16.6084423,10.7304545 L10.7406818,16.59822 C10.280287,17.0591273 9.65554997,17.3181054 9.00409091,17.3181054 C8.35263185,17.3181054 7.72789481,17.0591273 7.26815877,16.5988788 L0.239976954,9.57887876 C0.0863319284,9.4254126 0,9.21716044 0,9 L0,0.818181818 C0,0.366312477 0.366312477,0 0.818181818,0 L9,0 C9.21699531,0 9.42510306,0.0862010512 9.57854191,0.239639906 L16.6084423,7.26954545 C17.5601275,8.22691012 17.5601275,9.77308988 16.6084423,10.7304545 Z M5,6 C4.44771525,6 4,5.55228475 4,5 C4,4.44771525 4.44771525,4 5,4 C5.55228475,4 6,4.44771525 6,5 C6,5.55228475 5.55228475,6 5,6 Z">
                                                </path>
                                            </svg>
                                            <span class="ml-1">activewear</span></a>
                                    </div>
                                    <hr>
                                    <p class="text-base leading-8 my-5">
                                        Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem
                                        Ipsum has been the
                                        industry's standard dummy text ever since the 1500s, when an unknown printer
                                        took a galley of type
                                        and scrambled it to make a type specimen book. It has survived not only five
                                        centuries, but also the
                                        leap into electronic typesetting, remaining essentially unchanged. It was
                                        popularised in the 1960s
                                        with the release of Letraset sheets containing Lorem Ipsum passages, and more
                                        recently with desktop
                                        publishing software like Aldus PageMaker including versions of Lorem Ipsum.
                                    </p>

                                    <h3 class="text-2xl font-bold my-5">#1. What is Lorem Ipsum?</h3>

                                    <p class="text-base leading-8 my-5">
                                        Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem
                                        Ipsum has been the
                                        industry's standard dummy text ever since the 1500s, when an unknown printer
                                        took a galley of type
                                        and scrambled it to make a type specimen book. It has survived not only five
                                        centuries, but also the
                                        leap into electronic typesetting, remaining essentially unchanged. It was
                                        popularised in the 1960s
                                        with the release of Letraset sheets containing Lorem Ipsum passages, and more
                                        recently with desktop
                                        publishing software like Aldus PageMaker including versions of Lorem Ipsum.
                                    </p>

                                    <blockquote class="text-md italic leading-8 my-5 p-5 text-indigo-600 font-semibold">
                                        Lorem Ipsum is
                                        simply dummy text of the printing and typesetting industry. Lorem Ipsum has been
                                        the industry's
                                        standard dummy text ever since the 1500s</blockquote>

                                    <p class="text-base leading-8 my-5">
                                        Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem
                                        Ipsum has been the
                                        industry's standard dummy text ever since the 1500s, when an unknown printer
                                        took a galley of type
                                        and scrambled it to make a type specimen book. It has survived not only five
                                        centuries, but also the
                                        leap into electronic typesetting, remaining essentially unchanged. It was
                                        popularised in the 1960s
                                        with the release of Letraset sheets containing Lorem Ipsum passages, and more
                                        recently with desktop
                                        publishing software like Aldus PageMaker including versions of Lorem Ipsum.
                                    </p>


                                    <a href="#"
                                        class="text-xs text-indigo-600 font-medium hover:text-gray-900 transition duration-500 ease-in-out">
                                        #Election
                                    </a>,
                                    <a href="#"
                                        class="text-xs text-indigo-600 font-medium hover:text-gray-900 transition duration-500 ease-in-out">
                                        #people
                                    </a>,
                                    <a href="#"
                                        class="text-xs text-indigo-600 font-medium hover:text-gray-900 transition duration-500 ease-in-out">
                                        #Election2020
                                    </a>,
                                    <a href="#"
                                        class="text-xs text-indigo-600 font-medium hover:text-gray-900 transition duration-500 ease-in-out">
                                        #trump
                                    </a>,
                                    <a href="#"
                                        class="text-xs text-indigo-600 font-medium hover:text-gray-900 transition duration-500 ease-in-out">
                                        #Joe
                                    </a>

                                </div>

                            </div>
                        </div>
                    </div>



                    <jsp:include page="footer.jsp" />


                </body>

                </html>
                <!-- Font Awesome -->