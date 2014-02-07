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

#include "applicationui.hpp"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/LocaleHandler>
#include <QSettings>

//For Static ActiveFrame
#include <bb/cascades/SceneCover>
#include <bb/cascades/Container>

//For Dynamic ActiveFrame
#include "ActiveFrameUpdater.h"

#include "QmlBeam.h"

using namespace bb::cascades;

ApplicationUI::ApplicationUI(bb::cascades::Application *app) :
        QObject(app)
{
    QCoreApplication::setOrganizationName("KRol");
    QCoreApplication::setApplicationName("DoIt GoPro");

    // prepare the localization
    m_pTranslator = new QTranslator(this);
    m_pLocaleHandler = new LocaleHandler(this);

    bool res = QObject::connect(m_pLocaleHandler, SIGNAL(systemLanguageChanged()), this, SLOT(onSystemLanguageChanged()));
    // This is only available in Debug builds
    Q_ASSERT(res);
    // Since the variable is not used in the app, this is added to avoid a
    // compiler warning
    Q_UNUSED(res);

    // initial load
    onSystemLanguageChanged();

    // Create scene document from main.qml asset, the parent is set
    // to ensure the document gets destroyed properly at shut down.
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);

    //set context for using as QSettings
    qml->setContextProperty("doitsettings",this);

    //Create the Dynamic ActiveFrame using ActiveFrameUpdater.qml
    ActiveFrameUpdater *activeFrame = new ActiveFrameUpdater();
    Application::instance()->setCover(activeFrame);
    qml->setContextProperty("activeFrame", activeFrame);


    // Create root object for the UI
    AbstractPane *root = qml->createRootObject<AbstractPane>();
    // Set created root object as the application scene
    app->setScene(root);

    new QmlBeam(this);
    //Creates the Static ActiveFrame
    //addActiveFrame();
}

QString ApplicationUI::getSettings(const QString &settingObject)
{
	QSettings settings;

	//if (settings.value(settingObject).isNull())
	//{
	//	return "";
	//}


	return settings.value(settingObject).toString();
}

void ApplicationUI::setSettings(const QString &settingObject, const QString &settingValue)
{
	QSettings settings;

	settings.setValue(settingObject, QVariant(settingValue));

}

void ApplicationUI::syncSettings()
{
	QSettings settings;
	settings.sync();
}


void ApplicationUI::addActiveFrame()
{

	QmlDocument *qmlCover = QmlDocument::create("asset:///DynamicFrame.qml").parent(this);


	if (!qmlCover->hasErrors()) {
		// Create the QML Container from using the QMLDocument.
		Container *coverContainer = qmlCover->createRootObject<Container>();

		// Create a SceneCover and set the application cover
		SceneCover *sceneCover = SceneCover::create().content(coverContainer);
		Application::instance()->setCover(sceneCover);
	}
}

void ApplicationUI::onSystemLanguageChanged()
{
    QCoreApplication::instance()->removeTranslator(m_pTranslator);
    // Initiate, load and install the application translation files.
    QString locale_string = QLocale().name();
    QString file_name = QString("DoIt_%1").arg(locale_string);
    if (m_pTranslator->load(file_name, "app/native/qm")) {
        QCoreApplication::instance()->installTranslator(m_pTranslator);
    }
}
