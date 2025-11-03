#include "AuthenticationManager.h"
#include <QTimer>
#include <QSettings>
#include <QJsonDocument>
#include <QJsonObject>
#include <QDebug>

AuthenticationManager::AuthenticationManager(QObject* parent)
    : QObject(parent)
    , _networkManager(new QNetworkAccessManager(this))
{
    checkStoredCredentials();
}

AuthenticationManager::~AuthenticationManager() = default;

void AuthenticationManager::login(const QString& username, const QString& password)
{
    setLoading(true);
    setError("");

    // 🔹 TEST MODE (no API request)
    qDebug() << "Simulated login attempt for:" << username;

    // Simulate network delay with QTimer
    QTimer::singleShot(1000, this, [=]() {
        // Simple local validation logic
        if (username == "admin" && password == "1234") {
            _token = "dummy_token_ABC123";
            _currentUser = username;
            saveCredentials(_token);

            setAuthenticated(true);
            setLoading(false);

            qDebug() << "Simulated login success for:" << username;
            emit userChanged();
            emit loginSucceeded();
        } else {
            setError("Invalid username or password");
            setLoading(false);
            emit loginFailed("Invalid username or password");
        }
    });
}

void AuthenticationManager::handleLoginResponse()
{
    // Not used in test mode
}

void AuthenticationManager::logout()
{
    _isAuthenticated = false;
    _currentUser.clear();
    _token.clear();

    QSettings settings;
    settings.remove("auth/token");

    emit authenticationChanged();
    emit userChanged();
}

void AuthenticationManager::checkStoredCredentials()
{
    QString token = loadStoredToken();
    if (!token.isEmpty()) {
        _token = token;
        setAuthenticated(true);
        emit userChanged();
    }
}

void AuthenticationManager::saveCredentials(const QString& token)
{
    QSettings settings;
    settings.setValue("auth/token", token);
}

QString AuthenticationManager::loadStoredToken()
{
    QSettings settings;
    return settings.value("auth/token", "").toString();
}

void AuthenticationManager::setAuthenticated(bool authenticated)
{
    if (_isAuthenticated != authenticated) {
        _isAuthenticated = authenticated;
        emit authenticationChanged();
    }
}

void AuthenticationManager::setLoading(bool loading)
{
    if (_isLoading != loading) {
        _isLoading = loading;
        emit loadingChanged();
    }
}

void AuthenticationManager::setError(const QString& error)
{
    if (_errorMessage != error) {
        _errorMessage = error;
        emit errorChanged();
    }
}
