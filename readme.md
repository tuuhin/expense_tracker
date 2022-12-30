# 💸Expense Tracker

A **money** tracking app made using flutter with a custom app [**backend**](https://github.com/tuuhin/expense_tracker_backend).

<!-- For more 📸 screnshots head to `screenshot` folder. -->

## 📰 Description

This is a expense tracker which will trackup with you expense data, the app comes with a **user** **auth** system with a profile i.e, you have a _customizable_ _profile_. A budget mechanism is added so that the expenses can be made track off.

## 🍮 User Interface and Idea

I have tried to follow a design found on [dribble.com](https://dribbble.com/shots/16575527-Flux-Expense-Management-UI-Kit),but as the data demanded changed most of the parts. The idea for this app is found on [youtube.com](https://www.youtube.com/watch?v=nKzJGcewyUU) given by [philipp lackner](https://www.youtube.com/@PhilippLackner).

## 🧱 Structure

For better understanding of the project the project is divided via layers mainly the **data** ,**domain** and **app**.

- 🟡 **DATA**
  The data layer specilizes in data fetching cahing and acts as a connector between the domain layer models and the Ui layer here the app.The contents of this layer are .

  - **Dto**(Data Transfer Objects) classes which 🏪 transfer the Json Data into Dart Objects
  - Entity which are extended with [HiveObject](https://docs.hivedb.dev/#/) which object will be stored as cached data.
  - Local contains the **Dao**(Data access obejcts) which helps to 🛫interact i.e, the CRUD operartions with the databse
  - Remote contains all the **REST**(Restful) api implementations that the app used to connect to server for the data
  - The Respository contains all the repo **implementations** that are used in the app

- 🔴 **DOMAIN**
  The domain layer contains the models that the UI layer uses to present or change data,along with models it contains the abstact **repository** which can be implemented to present the available interactions

- 🟢 **CONTEXT**
  This layer contains as the [Service Locator](https://www.geeksforgeeks.org/service-locator-pattern).These services need to be injected to the app layer,buy the methods available on those Object one can produce the _changes_ in the app like fetching new data,adding data.
  This app uses the [bloc](https://www.kodeco.com/31973428-getting-started-with-the-bloc-pattern) pattern using [flutter_bloc](https://pub.dev/packages/flutter_bloc).
  The Objects now have depedency that are added at the root level for example

  This is the repostiory for the profile service

  ```dart
   RepositoryProvider<SomeRepository>(
      create: (context) => SomeRepositoryImpl(
        di: CustomDependency()),
  )
  ```

  This service acts as a dependency for the ProfileCubit

  ```dart
   BlocProvider<SomeBloc>(
      create: (context) => SomeBloc(
          context.read<SomeRepository>())),
  ```

  Now to interact with the ProfileCubit with the help of [flutter_bloc](https://pub.dev/packages/flutter_bloc) package

  ```dart
  context.read<SomeBloc>().changeIt();
  ```

- 🟣 **App**
  The app layer is self explanatory it contains the **UI**, as this app has a lot of functions I have put all the service locators at the root level.
  For routing I have used [go_router](https://pub.dev/packages/go_router)

  The basic router stucture

  ```dart
  final router = GoRouter(
      initialLocation: '/',
      routes: [
          GoRoute(path: '/', builder: (context, state) => const Home()),
          GoRoute(
          path: '/settings',
          builder: (context, state) => const Settings(),
      ),
  ```

  Not explaing the Ui layer much here it just contain a bunch od widgets and routes.

### 💠 Features

The app contains a lot of features to be discussed,most of the features avaliable with the [backend](https://github.com/tuuhin/expense_tracker_backend) are implemented in the client.

- 👮 **Authentication**
  As per the sever toekn based authentication is implemented [JWT](https://jwt.io/). The tokens are sucurely stored in the app via [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage).The **clients** are paired up with a _auth interceptors_ which will add the **Authorization** token in the header and ask for the new token when the access token get expires.
- 🥳 **Profile**
  A user can change his profile, the profile data is a stream thus the user can see the current changes on the way after the change has been made.
- 🎛️ **Budget,Goals and Others**
  The other features like expenses ,income,sources,category are queried over to the server the previous cached data is removed, and the new added data is read.

### 🏁Todos

A project is never finish, ideas will be blooming in the process of development thus adding a ✔️ **checklist** of those if decided to implement latter.

- [ ] 🧹 **Cleaner UI**
      The UI of the app is clean but it can be much more customized to look even better

- [ ] 🦀 **Proper Error Messages**
      Due to the lack of time the error messages aren't that good, those dont provide the user with perfect reason of error

- [ ] 💫 **Retry**
      Being a CRUD operation heavy app , there should be an option to retry. If the request failed for some reason.

- [ ] 📊 **Charts**
      An expense app should alawys have a chart to show the changes,This is an important feature and should had been taken into account previously.

### 🏃 Run the App

This is the client for the **expense_tracker** server make sure you 🚀 run the server first.
To run the server follow the instructions on [backend](https://github.com/tuuhin/expense_tracker_backend).

To start this project on your local computermake sure [flutter](https://flutter.dev) installed on your local machine. otherwise follow the [installation](https://docs.flutter.dev/get-started/install) guide.

- Clone this repository

  ```bash
      git clone 'https://github.com/tuuhin/expense_tracker'
      cd expense_tracker
  ```

- Get dependencies

  ```bash
      flutter pub get
  ```

Some files are need to be generated to continue run the next _command_ to generate the files

- Generate `*.g.dart` and `*.freezed.dart` files

  ```bash
      flutter pub run build_runner build --delete-conflicting-outputs
  ```

🤔 This will take a minute or so, have some water for the movement.

You are all **done** here, you can now **run** the project.
