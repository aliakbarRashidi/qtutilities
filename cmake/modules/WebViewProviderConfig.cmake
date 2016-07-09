# determines the web view provider (either Qt WebKit or Qt WebEngine)

set(WEBVIEW_PROVIDER "auto" CACHE STRING "specifies the web view provider: auto (default), webkit, webengine or none")
if(${WEBVIEW_PROVIDER} STREQUAL "auto")
    find_package(Qt5WebKitWidgets)
    if(Qt5WebKitWidgets_FOUND)
        set(WEBVIEW_PROVIDER Qt5::WebKitWidgets)
        set(WEBVIEW_DEFINITION "-D${META_PROJECT_VARNAME_UPPER}_USE_WEBKIT")
        message(STATUS "No web view provider explicitly specified, defaulting to Qt WebKit.")
    else()
        find_package(Qt5WebEngineWidgets)
        if(Qt5WebEngineWidgets_FOUND)
            set(WEBVIEW_PROVIDER Qt5::WebEngineWidgets)
            set(WEBVIEW_DEFINITION "-D${META_PROJECT_VARNAME_UPPER}_USE_WEBENGINE")
            message(STATUS "No web view provider explicitly specified, defaulting to Qt WebEngine.")
        else()
            set(WEBVIEW_PROVIDER "")
            set(WEBVIEW_DEFINITION "-D${META_PROJECT_VARNAME_UPPER}_NO_WEBVIEW")
            message(STATUS "No web view provider available, web view has been disabled.")
        endif()
    endif()
else()
    if(${WEBVIEW_PROVIDER} STREQUAL "webkit")
        find_package(Qt5WebKitWidgets REQUIRED)
        set(WEBVIEW_PROVIDER Qt5::WebKitWidgets)
        set(WEBVIEW_DEFINITION "-D${META_PROJECT_VARNAME_UPPER}_USE_WEBKIT")
        message(STATUS "Using Qt WebKit as web view provider.")
    elseif(${WEBVIEW_PROVIDER} STREQUAL "webengine")
        find_package(Qt5WebEngineWidgets REQUIRED)
        set(WEBVIEW_PROVIDER Qt5::WebEngineWidgets)
        set(WEBVIEW_DEFINITION "-D${META_PROJECT_VARNAME_UPPER}_USE_WEBENGINE")
        message(STATUS "Using Qt WebEngine as web view provider.")
    elseif(${WEBVIEW_PROVIDER} STREQUAL "none")
        set(WEBVIEW_DEFINITION "-D${META_PROJECT_VARNAME_UPPER}_NO_WEBVIEW")
        set(WEBVIEW_PROVIDER "")
        message(STATUS "Web view has been disabled.")
    else()
        message(FATAL_ERROR "The specified web view provider '${WEBVIEW_PROVIDER}' is unknown.")
    endif()
endif()

list(APPEND LIBRARIES ${WEBVIEW_PROVIDER})
add_definitions(${WEBVIEW_DEFINITION})
