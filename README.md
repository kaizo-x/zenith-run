# 🏃 Zenith Run — Voice-Controlled 2D Endless Runner

**Zenith Run** is a 2D endless runner game built with **Godot Engine (GDScript)**. It features a unique dual-control paradigm allowing players to play using standard controls or **voice-activated volume commands** captured via real-time microphone input.

---

## 🚀 Live Demo

- **Vercel Deployment:** [Insert Your Vercel Link Here]

---

## ✨ Features

- **🎮 Dual Control Modes:**
  - **Standard Mode:** Keyboard bindings (`Space` / `Up Arrow` to Jump, `Down Arrow` to Duck) and on-screen touch buttons for mobile/touch screens.
  - **Voice Mode:** Real-time audio amplitude detection via microphone. Shouting/loud sounds trigger a **Jump**, while moderate speaking triggers a **Duck**.
- **🌵 Procedural Obstacle Spawning:** Alternating high and low obstacles that test player reaction time and control precision.
- **📊 Real-Time Score & High Score Persistence:** Live score tracking based on cleared obstacles with persistent session best scores.
- **⏸️ Interactive Pause & Navigation System:** Seamless pause overlay using `PROCESS_MODE_ALWAYS` to prevent unwanted updates while maintaining interactive HUD menus.
- **📱 Responsive Web Export:** Fully optimized for HTML5 / WebAssembly browser deployment.

---

## 🛠️ Tech Stack & Engine Details

- **Game Engine:** Godot Engine (v4.x)
- **Language:** GDScript
- **Audio Processing:** `AudioEffectCapture` on the Master Audio Bus
- **Target Export:** HTML5 / WebAssembly (Web)
- **Deployment Platform:** Vercel / GitHub Pages

---

## 🎛️ Audio Subsystem Setup

Voice input relies on capturing raw audio buffers directly from the Master bus to calculate instantaneous amplitude values:

1. **Audio Driver Input:** `Enable Input` turned `On` under Project Settings.
2. **Audio Bus Layout:** `AudioEffectCapture` added to Slot 0 on the **Master** bus.
3. **Threshold Logic:**
   - Volume $> 0.15 \rightarrow$ **Jump**
   - Volume $> 0.04 \text{ and } \le 0.15 \rightarrow$ **Duck**

---

## 📂 Project Structure

```text
├── Main.tscn / Main.gd           # Core gameplay scene, score manager, timer, & pause system
├── Player.tscn / Player.gd       # Character controller (physics, touch inputs, mic capture)
├── obstacle.tscn / obstacle.gd   # Procedural obstacle spawning, speed logic, & collision detection
├── ModeSelect.tscn / ModeSelect.gd # Menu interface for selecting Voice or Keyboard mode
├── Global.gd                     # Autoload singleton storing global settings & high scores
├── vercel.json                   # Cross-Origin Isolation headers for WebAssembly deployment
└── README.md
```

## ⚙️ Local Development Setup
### Clone the repository:

### Bash
git clone [https://github.com/YOUR_USERNAME/zenith-run.git](https://github.com/YOUR_USERNAME/zenith-run.git)
cd zenith-run
## Open in Godot Engine:

### Launch Godot Engine 4.x.

### Import the project by selecting project.godot.

### Enable Audio Input Settings:

### Navigate to Project -> Project Settings -> Audio -> Driver.

### Set Enable Input to On.

### Run the Project:

Press F5 to run the project. Choose Voice Mode or Keyboard Mode on the main menu to test.

🌐 Web Deployment (Vercel / GitHub Pages)
To run Godot Web exports properly in modern browsers, SharedArrayBuffer cross-origin isolation headers are required. The included vercel.json configures these headers automatically.ee to fork, modify, and build upon this project!
