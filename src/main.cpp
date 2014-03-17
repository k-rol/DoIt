/*
 * Copyright (c) 2011-2013 BlackBerry Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <bb/cascades/Application>

#include <QLocale>
#include <QTranslator>
#include "applicationui.hpp"



#include <Qt/qdeclarativedebug.h>

#include "GetterRequest.h"
#include "timer.h"



using namespace bb::cascades;

Q_DECL_EXPORT int main(int argc, char **argv)
{
    Application app(argc, argv);

    qmlRegisterType<GetterRequest>("Network.GetterRequest", 1, 0, "GetterRequest");
    qmlRegisterType<Timer>("CustomerTimer", 1, 0, "Timer");
    qmlRegisterType<QTimer>("QTimerLibrary", 1, 0, "QTimer");
    //qmlRegisterType<QTimer>("my.library", 1, 0, "QTimer");

    // Create the Application UI object, this is where the main.qml file
    // is loaded and the application scene is set.
    new ApplicationUI(&app);

    // Enter the application main event loop.
    return Application::exec();
}
