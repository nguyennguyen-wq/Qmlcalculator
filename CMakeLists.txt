cmake_minimum_required(VERSION 3.16)
project(QMLCalculator VERSION 0.1 LANGUAGES CXX)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(appQMLCalculator
    main.cpp
)

qt_add_qml_module(appQMLCalculator
    URI QMLCalculator
    VERSION 1.0
    QML_FILES
        Main.qml
        QML_FILES AllButtons.qml
        QML_FILES
        QML_FILES Button.qml
        QML_FILES
        QML_FILES BsButton.qml
        QML_FILES
        QML_FILES Operation.js
        QML_FILES
        QML_FILES Caloperations.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appQMLCalculator PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appQMLCalculator
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appQMLCalculator
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appQMLCalculator
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
