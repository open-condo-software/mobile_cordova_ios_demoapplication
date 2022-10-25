# Приветствуем! 

Это плейграунд Condo Miniapps для iOS, он ещё в процессе разработки, но уже позволяет пощупать реальный процесс взаимодействия с приложением.

Само приложение кордовы вы можете найти в папке MainCordovaApplication, где в папке www лежит пример взаимодействия с нативным апи и вы можете разработать что то своё.


___
# Содержание.
1. [Начало работы.](#getting_started)
2. [Основные методы.](#common_methods)
3. [Тестирование.](#testing)
4. [Публикация.](#publishing)


---
# Начало работы. <a name="getting_started"></a>

1. Установка необходимых зависимостей:

    - убедитесь что у вас установлены последняя версия mac OS, Xcode и Xcode CLT

    - Убедитесь что нужные Xcode CLT выбраны, это можно сделать в настройках Xcode: 

        Xcode -> Preferences -> Locations -> Command Line Tools

    - установка homebrew
    
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        после чего выполните предложенные в терминале три команды для добавления homebrew в переменные окружения

            echo '# Set PATH, MANPATH, etc., for Homebrew.' >> ~/.zprofile
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"

    - установка cocoapods

            brew install cocoapods
        обратите внимание, что установка осуществляется не рекомендованным способом а через сторонний менеджер пакетов. если устанавливать по другому, то вы будете получать ошибки во время работы на современном оборудовании.

    - установка nvm, node и npm

        https://github.com/nvm-sh/nvm#installing-and-updating

    - установка Cordova

            npm install -g cordova

2. Редактирование приложения

    - откройте директорию проекта и перейдите в следующий подкаталог /MainCordovaApplication/www
        
        в ней будет находиться ваш код приложения, свободно редактируйте его
    
    - после редактирования кода в директории MainCordovaApplication нужно выполнить команду

            cordova prepare ios
        это подготовит все ваши изменения к запуску
    
3. Запуск и проверка приложения

    - в основной директории проекта выолните команду

            pod install
        эту команду достаточно выполнить всего один раз перед первым запуском
    
    - в основной директории проекта запустите файл CordovaDemoApp.xcworkspace. Обратите внимание на расширение.

    - после открытия проекта в Xcode запустите его
            
            cmd + R

4. Оптимизация
    
    Для того что бы после каждого изменения кода не приходилось выполнять в терминале команду cordova prepare ios вы можете настроить её автоматическую работу при запуске проекта в Xcode. Для этого сделайте следующие действия

    - откройте прокт в Xcode
    - во вкладке project navigator (cmd + 1) выберите самый верхний узел с названием CordovaDemoApp, у него будет синяя квадратная иконка со значком App Store
    - выберете CordovaDemoApp в подразделе TARGETS
    - откройте вкладку Build Phases
    - Раскройте 4 элемент в открывшемся списке с названием "Run Script"
    - добавьте в него строчку по примеру из комментария

            путь/до/установленной/cordova prepare ios 
        после этого при каждом запуске проекта соответствующая команда будет выполняться автоматически.


 ---
# Основные методы. <a name="common_methods"></a>
- авторизация

    function requestServerAuthorizationByUrl(miniapp_server_init_auth_url, custom_params_reserver_for_future_use, success, error) 

    пример:

            cordova.plugins.condo.requestServerAuthorizationByUrl('https://miniapp.d.doma.ai/oidc/auth', {}, function(response) {
                console.log('recive authorication result => ', JSON.stringify(response));
                window.location.reload();
            }, function(error) {
                console.log(error);
            });

- получение текущего резидента\адреса

    function getCurrentResident(success, error)

    пример:

            cordova.plugins.condo.getCurrentResident(function(response) {
                console.log("current resident\address => ", JSON.stringify(response));
            }, function(error) {
                console.log(error);
            });

- закрытие приложения

    function closeApplication(success, error)

    пример:

            cordova.plugins.condo.closeApplication(function(response) {}, function(error) {});


---
# Тестирование(начиная с 01.11.2022).  <a name="testing"></a>
1.  откройте директорию проекта и перейдите в следующий подкаталог 
        
        /MainCordovaApplication/platforms/ios/
    в нём вы найдёте директорию www.
    Создайте zip архив из директории www, для этого нажмите правой кнопкой по папке и выберите пункт Compress "www".

2. Поместите полученный архив в iCloud хранилище аккаунта, подключенного к устройству на котором будете тестировать приложение.

3. Установите из AppStore приложение Doma и авторизуйтесь в нём
    https://apps.apple.com/us/app/doma/id1573897686

4. Приложение, скачанное вами, имеет встроенный функционал для отладки миниприложений. Для его включения и выключения используются ссылки, которые необходимо открыть на устройстве:
    
    - включение:
    
        ai.doma.client.service://miniapps/local/enable
    - выключение:
                    
        ai.doma.client.service://miniapps/local/disable

5. Теперь, на главном экране приложения в списке миниприложений последней кнопкой вам доступна загрузка или замена загруженного ранее миниприложения из файлов. По нажатию на неё необходимо выбрать загруженный ранее в iCloud архив.

6. Загруженное таким образом приложение имеет встроенную js консоль, которая доступна по нажатию на кнопку внизу справа на открытом миниприложении и способна показывать много дополнительной информации, включая различные ошибки.


---
# Публикация <a name="publishing"></a>
Для публикации миниприложения отправьте полученный на этапе тестирования архив людям из компании Doma с которыми вы взаимодействуете. 