<h1 align="center">Stupidly Simple Module Loader</h1>

<p align="center">
  <em>A stupidly simple module loader for RBXTS because sometimes all you need is something that just works.</em><br>
  Lightweight, dependency-free, and easy to drop into any project.
</p>

---

### ❓ What is a Module Loader?
A **module loader** is a module that automatically handles the initialization and startup of your modules.

Instead of manually managing dozens of `require()` calls across scripts, you can just use:
- 1 **Script**
- 1 **LocalScript**
- and a few **ModuleScripts** which the loader automatically initializes and starts.

This keeps your code **organized**, **modular**, and your workspace **clean**.

---

### ⭐ Features
- Initializes modules **automatically**  
- Starts modules **automatically**  
- Logs initialization and startup times  
- **Lightweight** & **dependency-free**

---

### 📦 Requirements
- `rbxts` **^3.0.0**

---

### Quick Setup
```typescript
import { StartAll } from "@rbxts/moduleloader";

const modules = script.Parent!.GetChildren();
await StartAll(modules);
```

---

### Installation
To install it is simple!
Just run 
```sh
npm install github:NotDumbDev/SimpleModuleLoader
```
on your terminal!

---

## 🤝 Feedback & Contributing
Contributing is always appreciated! feel free to contribute to this.

Feedback is also appreciated! 

If you find a bug / want a feature please DM me on discord or open an issue!
