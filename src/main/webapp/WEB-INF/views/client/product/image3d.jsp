<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fashion 3D Viewer</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Three.js Libraries -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/dat.gui/0.7.9/dat.gui.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/three@0.128.0/examples/js/controls/OrbitControls.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/three@0.128.0/examples/js/loaders/GLTFLoader.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/three@0.128.0/examples/js/loaders/DRACOLoader.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/three@0.128.0/examples/js/postprocessing/EffectComposer.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stats.js/r17/Stats.min.js"></script>

    <!-- Store variants data in a safer way -->
    <script id="variantsData" type="application/json">
        <c:out value="${variantsJson}" escapeXml="false" />
    </script>
    
    <style>
        .custom-file-input::-webkit-file-upload-button {
            visibility: hidden;
            display: none;
        }
        
        .shadow-inner-custom {
            box-shadow: inset 0 2px 4px 0 rgba(0, 0, 0, 0.2);
        }
        
        /* Custom styling for controls panel */
        .controls-panel {
            background-color: rgba(23, 23, 23, 0.95);
            border: 1px solid rgba(55, 55, 55, 0.5);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
        }
        
        .controls-panel .slider {
            -webkit-appearance: none;
            height: 6px;
            border-radius: 3px;
            background: #374151;
            outline: none;
        }
        
        .controls-panel .slider::-webkit-slider-thumb {
            -webkit-appearance: none;
            appearance: none;
            width: 16px;
            height: 16px;
            border-radius: 50%;
            background: #2563eb;
            cursor: pointer;
            transition: all 0.2s;
        }
        
        .controls-panel .slider::-webkit-slider-thumb:hover {
            background: #1d4ed8;
            transform: scale(1.1);
        }
        
        #canvas-container {
            touch-action: none;
        }
        
        /* Custom scrollbar for product grid */
        .custom-scrollbar::-webkit-scrollbar {
            width: 6px;
        }
        
        .custom-scrollbar::-webkit-scrollbar-track {
            background: rgba(30, 30, 30, 0.2);
            border-radius: 10px;
        }
        
        .custom-scrollbar::-webkit-scrollbar-thumb {
            background: rgba(100, 116, 139, 0.5);
            border-radius: 10px;
        }
        
        .custom-scrollbar::-webkit-scrollbar-thumb:hover {
            background: rgba(100, 116, 139, 0.8);
        }
        
        /* Product card hover effects */
        .product-card {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        
        .product-card:hover {
            transform: translateY(-4px) scale(1.02);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.4), 0 10px 10px -5px rgba(0, 0, 0, 0.2);
        }
        
        .product-card.selected {
            border-color: #3b82f6;
            box-shadow: 0 0 0 2px #3b82f6, 0 10px 15px -3px rgba(59, 130, 246, 0.3);
        }
        
        .color-dot {
            box-shadow: 0 0 0 1px rgba(255, 255, 255, 0.2);
        }
        
        /* 3D badge styles */
        .model-badge {
            background: linear-gradient(135deg, #3b82f6, #2563eb);
            box-shadow: 0 2px 4px rgba(37, 99, 235, 0.3);
            transition: all 0.2s;
        }
        
        .product-card:hover .model-badge {
            transform: scale(1.1);
        }
    </style>
</head>
<body class="bg-gray-900 text-white h-screen flex flex-col overflow-hidden">
    <!-- Header Navigation -->
    <div class="navbar bg-gray-900 text-white p-4 flex justify-between items-center z-10 shadow-lg">
        <div class="text-xl font-bold flex items-center">
            <span class="text-blue-400 mr-2">SHOP THỜI TRANG</span> <a href="${pageContext.request.contextPath}/product/detail?id=${param.id}" class="text-blue-400 mr-2">DDTS 3D IMAGE</a>
        </div>
        <div>
            <button id="resetButton" class="hidden bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded flex items-center transition-all duration-300 ease-in-out">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-8l-4-4m0 0L8 8m4-4v12" />
                </svg>
                XEM ẢNH KHÁC 
            </button>
        </div>
    </div>

    <!-- Main Content Area -->
    <div class="flex-1 flex">
        <!-- Left: Fashion Product Selection Area -->
        <div id="upload-container" class="flex-1 flex flex-col p-6 m-4 bg-gradient-to-br from-gray-900 via-gray-800 to-gray-900 rounded-xl shadow-2xl transition-all duration-300">
            <div class="text-center mb-6">
                <div class="inline-flex items-center justify-center bg-blue-500/10 p-3 rounded-full mb-4">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-blue-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
                    </svg>
                </div>
                <h2 class="text-3xl mb-2 font-bold text-white tracking-tight">Fashion Preview</h2>
                <p class="text-blue-300 max-w-md mx-auto" id="3d-instruction-text">Select a product variant to experience in 3D</p>
            </div>
            
            <div class="flex-1 flex flex-col">
                <!-- Product Variants Grid -->
                <div id="model-selector" class="grid grid-cols-2 md:grid-cols-3 gap-4 mb-8 max-h-[60vh] overflow-y-auto p-2 custom-scrollbar">
                    <!-- Available product variants will be populated here -->
                    <div id="no-models-message" class="text-yellow-400 hidden col-span-full flex items-center justify-center p-6 border border-yellow-600/20 bg-yellow-600/10 rounded-lg">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                        </svg>
                        Hình ảnh không có 3D
                    </div>
                </div>
                
                <div class="mt-auto border-t border-gray-700 pt-4 flex items-center justify-between">
                    <div class="text-xs text-gray-400 flex items-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1 text-blue-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                        Supported formats: GLB, GLTF
                    </div>
                    <div class="text-xs text-gray-500">
                        Click on a product to view in 3D
                    </div>
                </div>
            </div>
        </div>

        <!-- Right: 3D Viewer -->
        <div id="canvas-container" class="hidden flex-1 relative overflow-hidden">
            <!-- Loading indicator -->
            <div id="loading-indicator" class="absolute inset-0 bg-gray-900 bg-opacity-70 z-20 flex items-center justify-center">
                <div class="text-white bg-gray-800 p-6 rounded-lg shadow-lg max-w-sm w-full">
                    <svg class="animate-spin h-10 w-10 text-blue-500 mx-auto mb-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                    </svg>
                    <p class="text-center">Loading model...</p>
                    <div class="w-full bg-gray-700 rounded-full h-2.5 mt-4">
                        <div id="loading-progress" class="bg-blue-600 h-2.5 rounded-full" style="width: 0%"></div>
                    </div>
                </div>
            </div>
            
            <!-- Controls panel -->
            <div class="controls-panel absolute top-4 right-4 w-64 rounded-lg p-4 z-10">
                <div class="flex justify-between items-center mb-4">
                    <h3 class="font-bold text-white">Viewer Controls</h3>
                    <button id="toggle-controls" class="text-gray-400 hover:text-white">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                            <path fill-rule="evenodd" d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM9 15a1 1 0 011-1h6a1 1 0 110 2h-6a1 1 0 01-1-1z" clip-rule="evenodd" />
                        </svg>
                    </button>
                </div>
                
                <div id="controls-content">
                    <!-- Display Settings -->
                    <div class="mb-4">
                        <h4 class="text-sm font-medium text-gray-300 mb-2">Display</h4>
                        <div class="space-y-3">
                            <div>
                                <label class="block text-xs text-gray-400 mb-1">Preset</label>
                                <select id="preset" class="w-full bg-gray-700 border border-gray-600 rounded px-3 py-1.5 text-sm">
                                    <option value="Default">Default</option>
                                    <option value="Studio">Studio</option>
                                    <option value="Dramatic">Dramatic</option>
                                    <option value="Soft">Soft</option>
                                </select>
                            </div>
                            <div>
                                <label class="block text-xs text-gray-400 mb-1">Environment</label>
                                <select id="environment" class="w-full bg-gray-700 border border-gray-600 rounded px-3 py-1.5 text-sm">
                                    <option value="sunset">Sunset</option>
                                    <option value="dawn">Dawn</option>
                                    <option value="night">Night</option>
                                    <option value="warehouse">Warehouse</option>
                                    <option value="forest">Forest</option>
                                    <option value="apartment">Apartment</option>
                                    <option value="studio">Studio</option>
                                    <option value="city" selected>City</option>
                                    <option value="park">Park</option>
                                    <option value="lobby">Lobby</option>
                                </select>
                            </div>
                            <div>
                                <label class="block text-xs text-gray-400 mb-1">Background Color</label>
                                <input type="color" id="bgColor" value="#1a1a1a" class="w-full h-8 rounded cursor-pointer">
                            </div>
                            <div>
                                <label class="block text-xs text-gray-400 mb-1">Exposure: <span id="exposure-value">1.0</span></label>
                                <input type="range" id="exposure" min="0" max="3" step="0.01" value="1" class="slider w-full">
                            </div>
                        </div>
                    </div>
                    
                    <!-- Scene Settings -->
                    <div class="mb-4">
                        <h4 class="text-sm font-medium text-gray-300 mb-2">Scene</h4>
                        <div class="grid grid-cols-2 gap-2">
                            <div class="flex items-center">
                                <input type="checkbox" id="showGrid" class="mr-2 rounded border-gray-600 text-blue-500 focus:ring-blue-500">
                                <label class="text-xs text-gray-400">Grid</label>
                            </div>
                            <div class="flex items-center">
                                <input type="checkbox" id="showAxes" class="mr-2 rounded border-gray-600 text-blue-500 focus:ring-blue-500">
                                <label class="text-xs text-gray-400">Axes</label>
                            </div>
                            <div class="flex items-center">
                                <input type="checkbox" id="showShadows" checked class="mr-2 rounded border-gray-600 text-blue-500 focus:ring-blue-500">
                                <label class="text-xs text-gray-400">Shadows</label>
                            </div>
                            <div class="flex items-center">
                                <input type="checkbox" id="autoRotate" class="mr-2 rounded border-gray-600 text-blue-500 focus:ring-blue-500">
                                <label class="text-xs text-gray-400">Auto-Rotate</label>
                            </div>
                        </div>
                        <div class="mt-2">
                            <label class="block text-xs text-gray-400 mb-1">Rotation Speed: <span id="rotate-value">1.0</span></label>
                            <input type="range" id="rotateSpeed" min="0.1" max="5" step="0.1" value="1" class="slider w-full">
                        </div>
                    </div>
                    
                    <!-- Lighting Settings -->
                    <div class="mb-4">
                        <h4 class="text-sm font-medium text-gray-300 mb-2">Lighting</h4>
                        <div class="space-y-3">
                            <div>
                                <label class="block text-xs text-gray-400 mb-1">Ambient Light: <span id="ambient-value">0.5</span></label>
                                <input type="range" id="ambientIntensity" min="0" max="2" step="0.01" value="0.5" class="slider w-full">
                            </div>
                            <div>
                                <label class="block text-xs text-gray-400 mb-1">Direct Light: <span id="direct-value">1.0</span></label>
                                <input type="range" id="directionalIntensity" min="0" max="3" step="0.01" value="1" class="slider w-full">
                            </div>
                        </div>
                    </div>
                    
                    <!-- Performance Settings -->
                    <div>
                        <h4 class="text-sm font-medium text-gray-300 mb-2">Performance</h4>
                        <div class="space-y-3">
                            <div class="flex items-center">
                                <input type="checkbox" id="showStats" class="mr-2 rounded border-gray-600 text-blue-500 focus:ring-blue-500">
                                <label class="text-xs text-gray-400">Show Stats</label>
                            </div>
                            <div>
                                <label class="block text-xs text-gray-400 mb-1">Shadow Quality</label>
                                <select id="shadowQuality" class="w-full bg-gray-700 border border-gray-600 rounded px-3 py-1.5 text-sm">
                                    <option value="off">Off</option>
                                    <option value="basic">Basic</option>
                                    <option value="soft" selected>Soft</option>
                                    <option value="high-quality">High Quality</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Screenshot Button -->
                    <div class="mt-4 pt-4 border-t border-gray-700">
                        <button id="screenshot-btn" class="w-full bg-indigo-600 hover:bg-indigo-700 text-white py-2 px-4 rounded flex items-center justify-center">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 9a2 2 0 012-2h.93a2 2 0 001.664-.89l.812-1.22A2 2 0 0110.07 4h3.86a2 2 0 011.664.89l.812 1.22A2 2 0 0018.07 7H19a2 2 0 012 2v9a2 2 0 01-2 2H5a2 2 0 01-2-2V9z" />
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 13a3 3 0 11-6 0 3 3 0 016 0z" />
                            </svg>
                            Take Screenshot
                        </button>
                    </div>
                </div>
            </div>
            
            <!-- Stats container -->
            <div id="stats-container" class="absolute top-4 left-4 z-10"></div>
            
            <!-- Canvas for Three.js -->
            <canvas id="model-canvas"></canvas>
        </div>
    </div>

    <!-- Screenshot Preview Modal -->
    <div id="screenshot-modal" class="fixed inset-0 bg-black bg-opacity-80 z-50 hidden flex items-center justify-center ">
        <div class="bg-gray-800 rounded-lg max-w-4xl w-full max-h-screen overflow-auto p-6 relative">
            <button id="close-modal" class="absolute top-4 right-4 text-gray-400 hover:text-white">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                </svg>
            </button>
            <h3 class="text-xl font-bold mb-4">Screenshot Preview</h3>
            <div class="flex flex-col items-center">
                <img id="screenshot-img" class="max-w-full max-h-[70vh] rounded shadow-lg mb-4" src="" alt="Model Screenshot">
                <div class="flex space-x-4">
                    <a id="download-btn" href="#" download="model-screenshot.png" class="bg-green-600 hover:bg-green-700 text-white py-2 px-6 rounded flex items-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4" />
                        </svg>
                        Download
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // DOM Elements
            const uploadContainer = document.getElementById('upload-container');
            const canvasContainer = document.getElementById('canvas-container');
            const loadingIndicator = document.getElementById('loading-indicator');
            const browseButton = document.getElementById('browseButton');
            const fileInput = document.getElementById('model-file');
            const resetButton = document.getElementById('resetButton');
            const toggleControlsBtn = document.getElementById('toggle-controls');
            const controlsContent = document.getElementById('controls-content');
            const screenshotBtn = document.getElementById('screenshot-btn');
            const screenshotModal = document.getElementById('screenshot-modal');
            const closeModalBtn = document.getElementById('close-modal');
            const screenshotImg = document.getElementById('screenshot-img');
            const downloadBtn = document.getElementById('download-btn');
            
            // Stats
            let stats;
            const showStatsCheckbox = document.getElementById('showStats');
            
            // Control values
            const exposureValue = document.getElementById('exposure-value');
            const rotateValue = document.getElementById('rotate-value');
            const ambientValue = document.getElementById('ambient-value');
            const directValue = document.getElementById('direct-value');
            
            // Three.js variables
            let scene, camera, renderer, controls, mixer;
            let model, grid, axesHelper;
            let ambientLight, directionalLight;
            let clock = new THREE.Clock();

            let variants = [];
            try {
                const rawJson = document.getElementById("variantsData").textContent.trim();
                console.log("Raw JSON data----:", rawJson);
                
                // Always try to parse the JSON from the server, regardless of placeholder
                try {
                    // First attempt direct parsing
                    variants = JSON.parse(rawJson);
                } catch (parseError) {
                    console.error("Direct parsing failed:", parseError);
                    
                    try {
                        // Try handling potential HTML entity encoding
                        const tempDiv = document.createElement('div');
                        tempDiv.innerHTML = rawJson;
                        const decodedJson = tempDiv.textContent;
                        variants = JSON.parse(decodedJson);
                        console.log("Parsed after HTML decoding");
                    } catch (secondError) {
                        console.error("Secondary parsing attempt failed:", secondError);
                        // Fallback to empty array which was already set
                    }
                }
                
                // Validate the parsed data
                if (variants && Array.isArray(variants)) {
                    console.log("Successfully parsed " + variants.length + " variants");
                } else {
                    console.error("Parsed result is not a valid array");
                    variants = [];
                }
                
                console.log("Variants loaded:", variants);
                
                // Start preloading 3D models right away
                preload3DModels();
                
                // Check if any variant has image_url3d
                const has3dModels = variants.some(function(variant) { 
                    return variant && variant.image_url3d; 
                });
                console.log("Has 3D models:", has3dModels);
                
                // Initialize 3D model buttons if variants contain 3D models
                populateModelOptions();
                
                // Check for saved state and restore it
                checkSavedState();
                
            } catch (e) {
                console.error("Error when parsing variantsJson:", e);
            }
            
            // Scene settings
            const settings = {
                preset: 'Default',
                environment: 'city',
                bgColor: '#1a1a1a',
                exposure: 1,
                showGrid: false,
                showAxes: false,
                showShadows: true,
                autoRotate: false,
                rotateSpeed: 1,
                ambientIntensity: 0.5,
                directionalIntensity: 1,
                lightPosition: { x: 5, y: 5, z: 5 },
                shadowQuality: 'soft'
            };
            
            // Initialize UI event listeners
            function initUI() {
                // Reset button
                resetButton.addEventListener('click', function() {
                    resetViewer();
                });
                
                // Control panel toggle
                toggleControlsBtn.addEventListener('click', function() {
                    controlsContent.classList.toggle('hidden');
                });
                
                // Screenshot handling
                screenshotBtn.addEventListener('click', takeScreenshot);
                closeModalBtn.addEventListener('click', function() {
                    screenshotModal.classList.add('hidden');
                });
                
                // Control UI event listeners
                document.getElementById('preset').addEventListener('change', function(e) {
                    settings.preset = e.target.value;
                    applyPreset(settings.preset);
                    updateScene();
                });
                
                document.getElementById('environment').addEventListener('change', function(e) {
                    settings.environment = e.target.value;
                    updateScene();
                });
                
                document.getElementById('bgColor').addEventListener('input', function(e) {
                    settings.bgColor = e.target.value;
                    updateScene();
                });
                
                document.getElementById('exposure').addEventListener('input', function(e) {
                    settings.exposure = parseFloat(e.target.value);
                    exposureValue.textContent = settings.exposure.toFixed(2);
                    updateScene();
                });
                
                document.getElementById('showGrid').addEventListener('change', function(e) {
                    settings.showGrid = e.target.checked;
                    updateScene();
                });
                
                document.getElementById('showAxes').addEventListener('change', function(e) {
                    settings.showAxes = e.target.checked;
                    updateScene();
                });
                
                document.getElementById('showShadows').addEventListener('change', function(e) {
                    settings.showShadows = e.target.checked;
                    updateScene();
                });
                
                document.getElementById('autoRotate').addEventListener('change', function(e) {
                    settings.autoRotate = e.target.checked;
                    if (controls) controls.autoRotate = settings.autoRotate;
                });
                
                document.getElementById('rotateSpeed').addEventListener('input', function(e) {
                    settings.rotateSpeed = parseFloat(e.target.value);
                    rotateValue.textContent = settings.rotateSpeed.toFixed(1);
                    if (controls) controls.autoRotateSpeed = settings.rotateSpeed;
                });
                
                document.getElementById('ambientIntensity').addEventListener('input', function(e) {
                    settings.ambientIntensity = parseFloat(e.target.value);
                    ambientValue.textContent = settings.ambientIntensity.toFixed(2);
                    updateScene();
                });
                
                document.getElementById('directionalIntensity').addEventListener('input', function(e) {
                    settings.directionalIntensity = parseFloat(e.target.value);
                    directValue.textContent = settings.directionalIntensity.toFixed(2);
                    updateScene();
                });
                
                document.getElementById('shadowQuality').addEventListener('change', function(e) {
                    settings.shadowQuality = e.target.value;
                    updateScene();
                });
                
                showStatsCheckbox.addEventListener('change', function(e) {
                    if (e.target.checked) {
                        initStats();
                    } else if (stats) {
                        document.getElementById('stats-container').innerHTML = '';
                        stats = null;
                    }
                });
            }
            
            // Handle file drag events
            function handleDrag(e) {
                e.preventDefault();
                e.stopPropagation();
                
                if (e.type === 'dragenter' || e.type === 'dragover') {
                    uploadContainer.classList.remove('border-gray-600');
                    uploadContainer.classList.add('border-blue-500', 'bg-blue-900/20');
                } else if (e.type === 'dragleave') {
                    uploadContainer.classList.add('border-gray-600');
                    uploadContainer.classList.remove('border-blue-500', 'bg-blue-900/20');
                }
            }
            
            // Handle file drop
            function handleDrop(e) {
                e.preventDefault();
                e.stopPropagation();
                
                uploadContainer.classList.add('border-gray-600');
                uploadContainer.classList.remove('border-blue-500', 'bg-blue-900/20');
                
                if (e.dataTransfer.files && e.dataTransfer.files[0]) {
                    handleFileUpload(e.dataTransfer.files[0]);
                }
            }
            
            // Handle file upload
            function handleFileUpload(file) {
                if (file.name.toLowerCase().endsWith('.glb') || file.name.toLowerCase().endsWith('.gltf')) {
                    // Show canvas and loading indicator
                    uploadContainer.classList.add('hidden');
                    canvasContainer.classList.remove('hidden');
                    loadingIndicator.classList.remove('hidden');
                    resetButton.classList.remove('hidden');
                    
                    // Initialize 3D viewer if it hasn't been initialized yet
                    if (!renderer) {
                        initViewer();
                    }
                    
                    // Load the model
                    loadModel(file);
                } else {
                    alert('Please select a valid GLB or GLTF file.');
                }
            }
            
            // Load model from URL
            function loadModelFromURL(url) {
                console.log("Starting to load 3D model from URL:", url);
                
                // Save current model URL to localStorage
                localStorage.setItem('currentModelURL', url);
                
                // Show canvas and loading indicator
                uploadContainer.classList.add('hidden');
                canvasContainer.classList.remove('hidden');
                loadingIndicator.classList.remove('hidden');
                resetButton.classList.remove('hidden');
                
                // Reset progress bar
                document.getElementById('loading-progress').style.width = '0%';
                
                // Initialize 3D viewer if it hasn't been initialized yet
                if (!renderer) {
                    console.log("Initializing 3D viewer");
                    initViewer();
                }
                
                // Check if this model was preloaded AFTER viewer initialization
                if (preloadedModels[url]) {
                    console.log("Using preloaded model");
                    processLoadedModel(preloadedModels[url]);
                    return;
                }
                
                // Use low quality during loading
                if (renderer) {
                    renderer.setPixelRatio(1);
                    renderer.shadowMap.enabled = false;
                }
                
                // Create loader
                const loader = new THREE.GLTFLoader();
                
                // Optional: Setup Draco decoder for compressed models
                const dracoLoader = new THREE.DRACOLoader();
                dracoLoader.setDecoderPath('https://www.gstatic.com/draco/v1/decoders/');
                loader.setDRACOLoader(dracoLoader);
                
                // Implement caching to avoid reloading the same model
                if (THREE.Cache.enabled === false) {
                    THREE.Cache.enabled = true;
                }
                
                console.log("Loading 3D model from URL:", url);
                
                // Preload textures for better performance
                const textureLoader = new THREE.TextureLoader();
                textureLoader.crossOrigin = '';
                
                // Create a timeout to handle slow loads
                const loadTimeout = setTimeout(() => {
                    console.log("Model loading taking longer than expected...");
                }, 5000);
                
                // Load the model from URL
                loader.load(
                    url,
                    function(gltf) {
                        clearTimeout(loadTimeout);
                        console.log("3D model loaded successfully");
                        
                        // Restore renderer quality
                        if (renderer) {
                            renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
                            renderer.shadowMap.enabled = settings.showShadows;
                        }
                        
                        // Process the loaded model
                        processLoadedModel(gltf);
                    },
                    // Progress callback
                    function(xhr) {
                        if (xhr.lengthComputable) {
                            const percentComplete = xhr.loaded / xhr.total * 100;
                            console.log(percentComplete.toFixed(2) + '% loaded');
                            // Update loading text with percentage
                            const loadingText = document.querySelector('#loading-indicator p');
                            if (loadingText) {
                                loadingText.textContent = "Loading model... " + percentComplete.toFixed(0) + "%";
                            }
                            // Update progress bar
                            const progressBar = document.getElementById('loading-progress');
                            if (progressBar) {
                                progressBar.style.width = percentComplete + '%';
                            }
                        }
                    },
                    // Error callback
                    function(error) {
                        clearTimeout(loadTimeout);
                        console.error('Error loading 3D model:', error);
                        alert('Error loading 3D model: ' + (error.message || 'Unknown error'));
                        resetViewer();
                        
                        // Restore renderer quality
                        if (renderer) {
                            renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
                            renderer.shadowMap.enabled = settings.showShadows;
                        }
                    }
                );
            }
            
            // Initialize the 3D viewer with optimized settings
            function initViewer() {
                // Create scene
                scene = new THREE.Scene();
                
                // Create camera with optimized near/far planes
                camera = new THREE.PerspectiveCamera(45, window.innerWidth / window.innerHeight, 0.1, 100);
                camera.position.set(5, 3, 8);
                
                // Create renderer with optimized settings
                const canvas = document.getElementById('model-canvas');
                renderer = new THREE.WebGLRenderer({
                    canvas: canvas,
                    antialias: false, // Disable antialiasing for better performance
                    alpha: true,
                    powerPreference: 'high-performance'
                });
                renderer.setSize(canvasContainer.clientWidth, canvasContainer.clientHeight);
                renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2)); // Limit pixel ratio for performance
                renderer.shadowMap.enabled = settings.showShadows;
                renderer.shadowMap.type = THREE.PCFSoftShadowMap;
                renderer.outputEncoding = THREE.sRGBEncoding;
                renderer.toneMapping = THREE.ACESFilmicToneMapping;
                renderer.toneMappingExposure = settings.exposure;
                
                // Create controls
                controls = new THREE.OrbitControls(camera, renderer.domElement);
                controls.enableDamping = true;
                controls.dampingFactor = 0.05;
                controls.screenSpacePanning = false;
                controls.minDistance = 1;
                controls.maxDistance = 100;
                controls.maxPolarAngle = Math.PI;
                controls.autoRotate = settings.autoRotate;
                controls.autoRotateSpeed = settings.rotateSpeed;
                
                // Create lights - simplified for performance
                ambientLight = new THREE.AmbientLight(0xffffff, settings.ambientIntensity);
                scene.add(ambientLight);
                
                directionalLight = new THREE.DirectionalLight(0xffffff, settings.directionalIntensity);
                directionalLight.position.set(
                    settings.lightPosition.x,
                    settings.lightPosition.y,
                    settings.lightPosition.z
                );
                directionalLight.castShadow = settings.showShadows;
                
                // Lower shadow map resolution for better performance
                directionalLight.shadow.mapSize.width = 1024;
                directionalLight.shadow.mapSize.height = 1024;
                
                // Set up shadow camera frustum
                directionalLight.shadow.camera.left = -10;
                directionalLight.shadow.camera.right = 10;
                directionalLight.shadow.camera.top = 10;
                directionalLight.shadow.camera.bottom = -10;
                directionalLight.shadow.camera.far = 50;
                
                scene.add(directionalLight);
                
                // Add minimal helper light
                const helperLight = new THREE.DirectionalLight(0xffffff, 0.3);
                helperLight.position.set(-5, 3, -5);
                scene.add(helperLight);
                
                // Add grid - only if needed
                grid = new THREE.GridHelper(20, 20, 0x444444, 0x888888);
                grid.visible = settings.showGrid;
                scene.add(grid);
                
                // Add axes helper - only if needed
                axesHelper = new THREE.AxesHelper(5);
                axesHelper.visible = settings.showAxes;
                scene.add(axesHelper);
                
                // Create simpler ground plane for shadows
                if (settings.showShadows) {
                    const groundGeometry = new THREE.PlaneGeometry(100, 100);
                    const groundMaterial = new THREE.ShadowMaterial({ opacity: 0.3 });
                    const groundPlane = new THREE.Mesh(groundGeometry, groundMaterial);
                    groundPlane.rotation.x = -Math.PI / 2;
                    groundPlane.position.y = -0.01; // Slightly below the grid
                    groundPlane.receiveShadow = true;
                    scene.add(groundPlane);
                }
                
                // Handle window resize
                window.addEventListener('resize', onWindowResize);
                
                // Start animation loop
                animate();
            }
            
            // Load 3D model from file
            function loadModel(file) {
                // Remove previous model if it exists
                if (model) {
                    scene.remove(model);
                    model = null;
                }
                
                // Create URL from the file
                const objectURL = URL.createObjectURL(file);
                
                // Create loader
                const loader = new THREE.GLTFLoader();
                
                // Optional: Setup Draco decoder for compressed models
                const dracoLoader = new THREE.DRACOLoader();
                dracoLoader.setDecoderPath('https://www.gstatic.com/draco/v1/decoders/');
                loader.setDRACOLoader(dracoLoader);
                
                // Load the model
                loader.load(
                    objectURL,
                    function(gltf) {
                        model = gltf.scene;
                        
                        // Setup model
                        model.traverse(function(node) {
                            if (node.isMesh) {
                                node.castShadow = true;
                                node.receiveShadow = true;
                                
                                // Enhance material quality
                                if (node.material) {
                                    if (Array.isArray(node.material)) {
                                        node.material.forEach(mat => {
                                            mat.envMapIntensity = 1;
                                            mat.needsUpdate = true;
                                        });
                                    } else {
                                        node.material.envMapIntensity = 1;
                                        node.material.needsUpdate = true;
                                    }
                                }
                            }
                        });
                        
                        // Add model to scene
                        scene.add(model);
                        
                        // Setup animations if available
                        if (gltf.animations && gltf.animations.length) {
                            mixer = new THREE.AnimationMixer(model);
                            const action = mixer.clipAction(gltf.animations[0]);
                            action.play();
                        }
                        
                        // Center and scale model appropriately
                        centerModel(model);
                        
                        // Hide loading indicator
                        loadingIndicator.classList.add('hidden');
                        
                        // Revoke object URL to free memory
                        URL.revokeObjectURL(objectURL);
                    },
                    // Progress callback
                    function(xhr) {
                        console.log((xhr.loaded / xhr.total * 100) + '% loaded');
                    },
                    // Error callback
                    function(error) {
                        console.error('Error loading model:', error);
                        alert('Error loading model. Please try another file.');
                        resetViewer();
                    }
                );
            }
            
            // Center and scale model to fit view
            function centerModel(model) {
                // Create bounding box
                const bbox = new THREE.Box3().setFromObject(model);
                const center = bbox.getCenter(new THREE.Vector3());
                const size = bbox.getSize(new THREE.Vector3());
                
                // Get maximum dimension
                const maxDim = Math.max(size.x, size.y, size.z);
                const fov = camera.fov * (Math.PI / 180);
                let cameraDistance = maxDim / (2 * Math.tan(fov / 2));
                
                // Add some padding
                cameraDistance *= 1.5;
                
                // Move model to center
                model.position.x = -center.x;
                model.position.y = -center.y;
                model.position.z = -center.z;
                
                // Update camera position
                const direction = new THREE.Vector3().subVectors(camera.position, new THREE.Vector3(0, 0, 0)).normalize();
                camera.position.copy(direction.multiplyScalar(cameraDistance));
                camera.near = cameraDistance / 100;
                camera.far = cameraDistance * 100;
                camera.updateProjectionMatrix();
                
                // Update controls target
                controls.target.set(0, 0, 0);
                controls.update();
            }
            
            // Animation loop
            function animate() {
                requestAnimationFrame(animate);
                
                // Update controls
                controls.update();
                
                // Update mixer (animations)
                if (mixer) {
                    mixer.update(clock.getDelta());
                }
                
                // Update stats if enabled
                if (stats) {
                    stats.update();
                }
                
                // Render scene
                renderer.render(scene, camera);
            }
            
            // Handle window resize
            function onWindowResize() {
                if (!renderer) return;
                
                camera.aspect = canvasContainer.clientWidth / canvasContainer.clientHeight;
                camera.updateProjectionMatrix();
                renderer.setSize(canvasContainer.clientWidth, canvasContainer.clientHeight);
            }
            
            // Apply preset configurations
            function applyPreset(preset) {
                if (preset === 'Studio') {
                    // Studio preset - clean, bright lighting
                    document.getElementById('environment').value = 'studio';
                    document.getElementById('bgColor').value = '#ffffff';
                    document.getElementById('ambientIntensity').value = 0.7;
                    document.getElementById('directionalIntensity').value = 0.8;
                    document.getElementById('showGrid').checked = false;
                    document.getElementById('showShadows').checked = true;
                    
                    settings.environment = 'studio';
                    settings.bgColor = '#ffffff';
                    settings.ambientIntensity = 0.7;
                    settings.directionalIntensity = 0.8;
                    settings.showGrid = false;
                    settings.showShadows = true;
                } else if (preset === 'Dramatic') {
                    // Dramatic preset - high contrast, theatrical
                    document.getElementById('environment').value = 'night';
                    document.getElementById('bgColor').value = '#000000';
                    document.getElementById('ambientIntensity').value = 0.3;
                    document.getElementById('directionalIntensity').value = 1.5;
                    document.getElementById('showGrid').checked = false;
                    document.getElementById('showShadows').checked = true;
                    
                    settings.environment = 'night';
                    settings.bgColor = '#000000';
                    settings.ambientIntensity = 0.3;
                    settings.directionalIntensity = 1.5;
                    settings.showGrid = false;
                    settings.showShadows = true;
                } else if (preset === 'Soft') {
                    // Soft preset - gentle lighting, subtle shadows
                    document.getElementById('environment').value = 'sunset';
                    document.getElementById('bgColor').value = '#f5f5f5';
                    document.getElementById('ambientIntensity').value = 0.8;
                    document.getElementById('directionalIntensity').value = 0.5;
                    document.getElementById('showGrid').checked = false;
                    document.getElementById('showShadows').checked = true;
                    
                    settings.environment = 'sunset';
                    settings.bgColor = '#f5f5f5';
                    settings.ambientIntensity = 0.8;
                    settings.directionalIntensity = 0.5;
                    settings.showGrid = false;
                    settings.showShadows = true;
                }
                
                // Update UI elements
                ambientValue.textContent = settings.ambientIntensity.toFixed(2);
                directValue.textContent = settings.directionalIntensity.toFixed(2);
            }
            
            // Update scene based on current settings
            function updateScene() {
                if (!scene || !renderer) return;
                
                // Update background color
                renderer.setClearColor(new THREE.Color(settings.bgColor));
                
                // Update exposure
                renderer.toneMappingExposure = settings.exposure;
                
                // Update grid visibility
                if (grid) grid.visible = settings.showGrid;
                
                // Update axes visibility
                if (axesHelper) axesHelper.visible = settings.showAxes;
                
                // Update lighting
                if (ambientLight) ambientLight.intensity = settings.ambientIntensity;
                if (directionalLight) {
                    directionalLight.intensity = settings.directionalIntensity;
                    directionalLight.castShadow = settings.showShadows;
                }
                
                // Update shadow settings
                if (renderer) {
                    renderer.shadowMap.enabled = settings.showShadows;
                    
                    switch (settings.shadowQuality) {
                        case 'off':
                            renderer.shadowMap.enabled = false;
                            break;
                        case 'basic':
                            renderer.shadowMap.enabled = true;
                            renderer.shadowMap.type = THREE.BasicShadowMap;
                            directionalLight.shadow.mapSize.width = 1024;
                            directionalLight.shadow.mapSize.height = 1024;
                            directionalLight.shadow.radius = 0;
                            break;
                        case 'soft':
                            renderer.shadowMap.enabled = true;
                            renderer.shadowMap.type = THREE.PCFSoftShadowMap;
                            directionalLight.shadow.mapSize.width = 2048;
                            directionalLight.shadow.mapSize.height = 2048;
                            directionalLight.shadow.radius = 4;
                            break;
                        case 'high-quality':
                            renderer.shadowMap.enabled = true;
                            renderer.shadowMap.type = THREE.PCFSoftShadowMap;
                            directionalLight.shadow.mapSize.width = 4096;
                            directionalLight.shadow.mapSize.height = 4096;
                            directionalLight.shadow.radius = 8;
                            break;
                    }
                }
            }
            
            // Reset viewer to initial state
            function resetViewer() {
                uploadContainer.classList.remove('hidden');
                canvasContainer.classList.add('hidden');
                resetButton.classList.add('hidden');
                
                // Clear saved state when resetting
                localStorage.removeItem('currentModelURL');
                
                if (model) {
                    scene.remove(model);
                    model = null;
                }
                
                if (mixer) {
                    mixer = null;
                }
                
                // Clear cache
                THREE.Cache.clear();
            }
            
            // Take screenshot
            function takeScreenshot() {
                // Render scene
                renderer.render(scene, camera);
                
                // Get data URL from canvas
                const dataURL = renderer.domElement.toDataURL('image/png');
                
                // Set image source
                screenshotImg.src = dataURL;
                downloadBtn.href = dataURL;
                
                // Show modal
                screenshotModal.classList.remove('hidden');
            }
            
            // Initialize stats
            function initStats() {
                stats = new Stats();
                stats.showPanel(0); // 0: fps, 1: ms, 2: mb, 3+: custom
                document.getElementById('stats-container').appendChild(stats.dom);
            }
            
            // Extract unique 3D model URLs from variants and create buttons for each one
            function populateModelOptions() {
                const modelSelector = document.getElementById('model-selector');
                const noModelsMessage = document.getElementById('no-models-message');
                
                // Clear any existing content
                modelSelector.innerHTML = '';
                
                // Make sure no-models-message is hidden by default
                noModelsMessage.classList.add('hidden');
                
                // Extract unique image_url3d values (excluding null values)
                const modelUrls = [];
                const variantDetails = [];
                if (variants && Array.isArray(variants)) {
                    variants.forEach(function(variant) {
                        if (variant && variant.image_url3d && !modelUrls.includes(variant.image_url3d)) {
                            // Safe approach to handle potentially missing properties
                            const colorName = variant.color && variant.color.name ? variant.color.name : '';
                            const colorHex = variant.color && variant.color.hex ? variant.color.hex : '#888888';
                            const sizeName = variant.size && variant.size.name ? variant.size.name : '';
                            const imageUrl = variant.image_url ? variant.image_url : '';
                            
                            modelUrls.push(variant.image_url3d);
                            variantDetails.push({
                                image_url: imageUrl,
                                image_url3d: variant.image_url3d,
                                color: colorName,
                                size: sizeName,
                                colorHex: colorHex
                            });
                        }
                    });
                }
                
                console.log("Available 3D model URLs:", modelUrls);
                console.log("Variant details:", variantDetails);
                
                if (modelUrls.length === 0) {
                    // No 3D models available
                    noModelsMessage.classList.remove('hidden');
                    document.getElementById('3d-instruction-text').textContent = "Hình ảnh không có 3D";
                    console.log("No 3D models available");
                    return;
                }
                
                // Re-add the no-models-message to modelSelector (it might have been cleared)
                modelSelector.appendChild(noModelsMessage);
                
                // Create a card for each model variant
                variantDetails.forEach(function(variant, index) {
                    const modelName = variant.color && variant.size 
                        ? variant.color + ' - ' + variant.size
                        : 'Variant ' + (index + 1);
                    
                    console.log("Creating card for model:", modelName, variant.image_url3d);
                    
                    const card = document.createElement('div');
                    card.className = 'product-card bg-gray-800 rounded-xl overflow-hidden shadow-lg border border-gray-700 hover:border-blue-500 cursor-pointer';
                    
                    // Build the card content with the variant image - avoiding template literals
                    const placeholderUrl = 'https://via.placeholder.com/300?text=No+Image';
                    const imgSrc = variant.image_url || placeholderUrl;
                    
                    card.innerHTML = 
                        '<div class="relative pb-[130%]">' +
                            '<img src="' + imgSrc + '"' + 
                                 ' alt="' + modelName + '"' + 
                                 ' class="absolute inset-0 w-full h-full object-cover"' +
                                 ' onerror="this.src=\'' + placeholderUrl + '\'">' +
                                 
                            '<div class="absolute inset-0 bg-gradient-to-t from-gray-900 via-transparent to-transparent"></div>' +
                            
                            '<div class="absolute top-3 right-3">' +
                                '<span class="model-badge inline-flex items-center px-2.5 py-1 rounded-full text-xs font-medium text-white">' +
                                    '<svg xmlns="http://www.w3.org/2000/svg" class="h-3.5 w-3.5 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">' +
                                        '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 10l-2 1m0 0l-2-1m2 1v2.5M20 7l-2 1m2-1l-2-1m2 1v2.5M14 4l-2-1-2 1M4 7l2-1M4 7l2 1M4 7v2.5M12 21l-2-1m2 1l2-1m-2 1v-2.5M6 18l-2-1v-2.5M18 18l2-1v-2.5" />' +
                                    '</svg>' +
                                    '3D' +
                                '</span>' +
                            '</div>' +
                            
                            '<div class="absolute bottom-0 left-0 right-0 p-3">' +
                                '<div class="flex items-center gap-2 mb-1">' +
                                    '<span class="color-dot w-5 h-5 rounded-full flex-shrink-0" style="background-color: ' + variant.colorHex + '"></span>' +
                                    '<h3 class="text-white font-medium text-sm truncate">' + (variant.color || 'Color') + '</h3>' +
                                '</div>' +
                                '<div class="flex justify-between items-center">' +
                                    '<span class="bg-gray-700 text-gray-300 px-2 py-0.5 rounded text-xs">' + (variant.size || 'Size') + '</span>' +
                                    '<span class="text-blue-400 text-xs font-medium">View in 3D</span>' +
                                '</div>' +
                            '</div>' +
                        '</div>';
                    
                    // Add click event handler
                    card.addEventListener('click', function() {
                        console.log("Loading 3D model from URL:", variant.image_url3d);
                        
                        // Add a visual indication that this card is selected
                        const allCards = document.querySelectorAll('#model-selector > div');
                        for (let i = 0; i < allCards.length; i++) {
                            allCards[i].classList.remove('selected');
                        }
                        card.classList.add('selected');
                        
                        loadModelFromURL(variant.image_url3d);
                    });
                    
                    modelSelector.appendChild(card);
                });
                
                // If there's only one model, load it automatically
                if (modelUrls.length === 1) {
                    console.log("Auto-loading single 3D model:", modelUrls[0]);
                    setTimeout(function() {
                        // Add selection indicator to the single card
                        const singleCard = modelSelector.querySelector('.product-card');
                        if (singleCard) {
                            singleCard.classList.add('selected');
                        }
                        loadModelFromURL(modelUrls[0]);
                    }, 500);
                }
            }
            
            // Preload 3D models
            const preloadedModels = {};
            function preload3DModels() {
                if (!variants || !Array.isArray(variants)) return;
                
                // Get unique 3D model URLs
                const modelUrls = [];
                variants.forEach(variant => {
                    if (variant && variant.image_url3d && !modelUrls.includes(variant.image_url3d)) {
                        modelUrls.push(variant.image_url3d);
                    }
                });
                
                if (modelUrls.length === 0) return;
                
                console.log("Preloading 3D models:", modelUrls);
                
                // Create loader
                const loader = new THREE.GLTFLoader();
                const dracoLoader = new THREE.DRACOLoader();
                dracoLoader.setDecoderPath('https://www.gstatic.com/draco/v1/decoders/');
                loader.setDRACOLoader(dracoLoader);
                
                // Enable caching
                THREE.Cache.enabled = true;
                
                // Preload each model
                modelUrls.forEach(url => {
                    loader.load(
                        url,
                        function(gltf) {
                            console.log("Preloaded model:", url);
                            preloadedModels[url] = gltf;
                        },
                        null,
                        function(error) {
                            console.error('Error preloading model:', url, error);
                        }
                    );
                });
            }
            
            // Process a loaded model (either from direct load or preload)
            function processLoadedModel(gltf) {
                console.log("Processing loaded model");
                
                // Remove previous model if it exists
                if (model) {
                    console.log("Removing previous model");
                    scene.remove(model);
                    model = null;
                }
                
                model = gltf.scene;
                
                // Optimize model for performance
                model.traverse(function(node) {
                    if (node.isMesh) {
                        node.castShadow = settings.showShadows;
                        node.receiveShadow = settings.showShadows;
                        
                        // Use optimized materials where possible
                        if (node.material) {
                            if (Array.isArray(node.material)) {
                                node.material.forEach(mat => {
                                    mat.envMapIntensity = 1;
                                    mat.needsUpdate = true;
                                    // Reduce texture quality for better performance
                                    if (mat.map) {
                                        mat.map.anisotropy = 1;
                                        mat.map.minFilter = THREE.LinearFilter;
                                    }
                                });
                            } else {
                                node.material.envMapIntensity = 1;
                                node.material.needsUpdate = true;
                                // Reduce texture quality for better performance
                                if (node.material.map) {
                                    node.material.map.anisotropy = 1;
                                    node.material.map.minFilter = THREE.LinearFilter;
                                }
                            }
                        }
                    }
                });
                
                // Add model to scene
                console.log("Adding model to scene");
                scene.add(model);
                
                // Setup animations if available - disable if too performance heavy
                if (gltf.animations && gltf.animations.length) {
                    console.log("Setting up animations");
                    mixer = new THREE.AnimationMixer(model);
                    const action = mixer.clipAction(gltf.animations[0]);
                    action.play();
                }
                
                // Center and scale model appropriately
                console.log("Centering model");
                centerModel(model);
                
                // Hide loading indicator
                console.log("Model loaded and displayed");
                loadingIndicator.classList.add('hidden');
            }
            
            // Check for saved state and restore it
            function checkSavedState() {
                const savedModelURL = localStorage.getItem('currentModelURL');
                if (savedModelURL) {
                    console.log("Restoring saved model state:", savedModelURL);
                    
                    // Check if this URL exists in our variants
                    const modelExists = variants.some(variant => 
                        variant && variant.image_url3d === savedModelURL
                    );
                    
                    if (modelExists) {
                        // Delay slightly to ensure UI is ready
                        setTimeout(() => {
                            loadModelFromURL(savedModelURL);
                        }, 500);
                    } else {
                        // URL no longer valid, clear saved state
                        console.log("Saved model URL no longer exists in variants, clearing state");
                        localStorage.removeItem('currentModelURL');
                    }
                }
            }
            
            // Initialize everything
            initUI();
        });
    </script>
</body>
</html>