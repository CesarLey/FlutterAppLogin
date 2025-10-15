# Proyecto `login_app` - Interactive Login Form  
✅ **Todos los 4 Desafíos Completados**

Proyecto Flutter con pantalla de login interactiva usando arquitectura limpia y BLoC (Cubit).

## 🎯 Características Implementadas

### Base
- ✅ Arquitectura limpia con separación de capas
- ✅ Estados sellados (LoginInitial, LoginLoading, LoginSuccess, LoginFailure)
- ✅ Validación robusta de formularios (RegExp para email)
- ✅ Tema centralizado con soporte claro/oscuro
- ✅ Componentes reutilizables

### ✅ Desafío 1: Validación Avanzada y Autofocus
- RegExp completo: `r'^[a-zA-Z0-9_%+-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$'`
- FocusNode para navegación automática entre campos
- TextInputAction.next/done
- Función `_submitForm()` separada y reutilizable

### ✅ Desafío 2: Gestión Avanzada del Flujo con Cubit
- Estados sellados (abstract LoginState)
- Validación de credenciales: `test@example.com` / `SecretPass`
- AlertDialog para errores
- SnackBar verde para éxitos
- Limpieza automática del formulario
- Estado isRememberMeChecked preservado

### ✅ Desafío 3: Feedback Visual Dinámico
- BlocBuilder solo en botón (eficiencia)
- BlocListener separado para diálogos/SnackBar
- CircularProgressIndicator con color del tema
- Botón inteligente (deshabilita durante carga)

### ✅ Desafío 4: Componentización y Theming
- CustomFormField en `lib/src/core/presentation/widgets/core_widgets.dart`
- Tema centralizado en `lib/src/core/presentation/app_theme.dart`
- Logo responsive (40% ancho pantalla, límites 100-200px)
- Theme.of(context) idiomático (no constantes estáticas)

## 📁 Estructura del Proyecto

```
lib/
├── main.dart                          # Usa AppTheme centralizado
└── src/
    ├── core/
    │   └── presentation/
    │       ├── app_theme.dart         # Temas claro/oscuro
    │       └── widgets/
    │           └── core_widgets.dart  # CustomFormField
    └── features/
        └── auth/
            ├── application/
            │   ├── login_state.dart   # Estados sellados
            │   └── login_cubit.dart   # Lógica de negocio
            └── presentation/
                └── screens/
                    └── login_screen.dart  # UI
```

## 🚀 Ejecutar la App

### 1. Añadir logo (opcional)
```powershell
.\copy_logo_to_assets.ps1 -SourcePath 'C:\ruta\a\tu\imagen.png'
```

### 2. Ejecutar
```powershell
flutter pub get
flutter run -d 6TNZYXFI6LV4LBT8
```

## 🧪 Probar Funcionalidad

**Credenciales válidas:**
- Email: `test@example.com`
- Password: `SecretPass`

**Flujo:**
1. Email → presiona "siguiente" → foco cambia a password ✓
2. Password → presiona "listo" en teclado → envía formulario ✓
3. Botón muestra spinner 2s ✓
4. **Éxito**: SnackBar verde + formulario limpio ✓
5. **Error**: AlertDialog rojo ✓

## 💡 Principios Aplicados

- Arquitectura Limpia
- DRY (Don't Repeat Yourself)
- Responsabilidad Única
- Componentización
- Theming Idiomático
- Responsive Design
- Estado Eficiente

## 🛠️ Tecnologías

- Flutter SDK >=2.18.0 <3.0.0
- flutter_bloc ^8.1.1
- Material Design 3
