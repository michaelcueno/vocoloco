#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "networkconnection.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{

    NetworkConnection nc = new NetworkConnection();
    ui->setupUi(this);
    connect(ui->pushButton, SIGNAL(clicked()), nc, SLOT(postForm("THING")));
}

MainWindow::~MainWindow()
{
    delete ui;
}
