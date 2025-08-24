plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android") // 👈 mejor usar este alias moderno en lugar de "kotlin-android"
    // El plugin de Flutter debe ir después de Android y Kotlin
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services") // 👈 necesario para Firebase
}

android {
    namespace = "com.rutaiq.app" // ⚠️ cámbialo aquí si tu package_name en Firebase es diferente
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.rutaiq.app" // ⚠️ asegúrate que coincida con Firebase
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: agrega tu propio signingConfig para release
            // Firma con debug por ahora
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Firebase BoM (maneja versiones automáticamente)
    implementation(platform("com.google.firebase:firebase-bom:33.1.2"))

    // Firebase libs (agrega las que uses)
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-auth")
    implementation("com.google.firebase:firebase-firestore")
}
