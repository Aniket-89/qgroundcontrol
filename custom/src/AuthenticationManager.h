#pragma once

#include <QObject>
#include <QString>
#include <QNetworkAccessManager>
#include <QNetworkReply>

class AuthenticationManager : public QObject
{
    Q_OBJECT
    
    // Expose to QML via Q_PROPERTY
    Q_PROPERTY(bool isAuthenticated READ isAuthenticated NOTIFY authenticationChanged)
    Q_PROPERTY(QString currentUser READ currentUser NOTIFY userChanged)
    Q_PROPERTY(bool isLoading READ isLoading NOTIFY loadingChanged)
    Q_PROPERTY(QString errorMessage READ errorMessage NOTIFY errorChanged)
    
public:
    explicit AuthenticationManager(QObject* parent = nullptr);
    ~AuthenticationManager();
    
    // Getters for Q_PROPERTY
    bool isAuthenticated() const { return _isAuthenticated; }
    QString currentUser() const { return _currentUser; }
    bool isLoading() const { return _isLoading; }
    QString errorMessage() const { return _errorMessage; }
    
    // Invokable from QML
    Q_INVOKABLE void login(const QString& username, const QString& password);
    Q_INVOKABLE void logout();
    Q_INVOKABLE void checkStoredCredentials(); // Auto-login
    
signals:
    void authenticationChanged();
    void userChanged();
    void loadingChanged();
    void errorChanged();
    void loginSucceeded();
    void loginFailed(const QString& error);
    
private slots:
    void handleLoginResponse();
    
private:
    bool _isAuthenticated = false;
    QString _currentUser;
    QString _token;
    bool _isLoading = false;
    QString _errorMessage;
    
    QNetworkAccessManager* _networkManager;
    
    void setAuthenticated(bool authenticated);
    void setLoading(bool loading);
    void setError(const QString& error);
    void saveCredentials(const QString& token);
    QString loadStoredToken();
};