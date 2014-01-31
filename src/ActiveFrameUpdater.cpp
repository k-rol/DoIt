/*
 * ActiveFrameUpdater.cpp
 *
 *  Created on: 2014-01-30
 *      Author: cauellet
 */

#include "ActiveFrameUpdater.h"
#include <bb/cascades/SceneCover>
#include <bb/cascades/Container>
#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>

ActiveFrameUpdater::ActiveFrameUpdater(QObject *parent): SceneCover(parent) {
	QmlDocument *qml = QmlDocument::create("asset:///DynamicFrame.qml").parent(parent);
	Container *mainContainer = qml->createRootObject<Container>();
	setContent(mainContainer);

	m_coverLabel = mainContainer->findChild<Label*>("TheLabel");
	m_coverLabel->setParent(mainContainer);

}

void ActiveFrameUpdater::update(QString appText)
{
	m_coverLabel->setText(appText);
}

ActiveFrameUpdater::~ActiveFrameUpdater() {
	// TODO Auto-generated destructor stub
}

