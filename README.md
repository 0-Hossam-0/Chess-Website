# Software Requirements Specification (SRS)
**Project:** AI-Powered Chess Platform
**Team Size:** 4 Members
**Version:** 1.2

---

## 1. Executive Summary
A modern, web-based chess platform built with React, allowing users to play against a custom-built Artificial Intelligence. The system mimics the polished user experience of major platforms (like Chess.com) while leveraging a proprietary Neural Network (ResNet) backend for gameplay and analysis.

**Core Capabilities:**
* **Game Interface:** Responsive React-based UI with "Chess.com-like" aesthetics and interactivity.
* **AI Opponent:** Deep Learning-based bot with human-like playstyles.
* **Game Analysis:** Post-game review featuring an evaluation bar and win-probability graphs.
* **Training Infrastructure:** A Python-based pipeline for Supervised and Reinforcement Learning.

---

## 2. Actors & Roles
* **Player (User):** Registers, plays games, analyzes matches, customizes board themes.
* **Guest:** Plays unranked games against the AI without saving history.
* **Admin:** Manages datasets and monitors training performance.
* **AI Engine:** The backend service that calculates moves using the ResNet model.

---

## 3. High-Level Architecture

### Frontend (The "Client")
* **Tech:** React.js (Strict Requirement).
* **State Management:** Redux or React Context (for game state).
* **Logic:** `chess.js` (Move validation, FEN generation).
* **UI Library:** Tailwind CSS or Material UI (for the clean, flat aesthetic).

### Backend API (The "Hub")
* **Tech:** Python (FastAPI).
* **Responsibility:** User auth, managing game sessions, bridging the Frontend to the AI.

### AI Service (The "Brain")
* **Tech:** PyTorch, NumPy.
* **Hardware:** CUDA-enabled GPU (Consumer grade or Cloud).
* **Architecture:** ResNet-19 + Monte Carlo Tree Search (MCTS).

### Database
* **Tech:** PostgreSQL.
* **Storage:** User profiles, PGN game records, and training checkpoints.

---

## 4. Detailed Frontend Requirements (Chess.com Style)

### 4.1 Layout & Structure (The "Holy Grail" Layout)
* **Responsive Grid:** The app must fit 100% of the viewport height (no scrolling during gameplay).
* **Center Stage (The Board):**
    * The board must be a perfect square, resizing dynamically to fit the screen while maintaining aspect ratio.
    * Must support high-resolution assets (SVG pieces).
* **Right Sidebar (The Info Panel):**
    * **Top:** Opponent Profile (Name, Avatar, Rating).
    * **Middle:** Move History List (Standard Algebraic Notation, e.g., `1. e4 e5`).
        * *Requirement:* Clicking a past move immediately updates the board to that state for review.
    * **Bottom:** Player Profile & Game Controls (Resign, Draw, Flip Board).

### 4.2 Board Interactivity
* **Input Methods:**
    * **Drag & Drop:** Smooth, lag-free dragging of pieces.
    * **Click-to-Move:** Click source square (highlight), click destination square (move).
* **Visual Cues:**
    * **Legal Move Dots:** When a piece is grabbed, show small dots on all valid destination squares.
    * **Last Move Highlight:** Highlights the start and end squares of the previous move in yellow/translucent color.
    * **Check Highlight:** The King's square glows red when in check.
* **Sound Effects:**
    * Distinct sounds for: *Move, Capture, Castle, Check, Game Over*.

### 4.3 The "Evaluation Bar" (Analysis Mode)
* **Visual Bar:** A vertical bar next to the board that fluctuates based on the AI's "Value Head" output.
    * **White Advantage:** Bar fills up white from the bottom.
    * **Black Advantage:** Bar fills down black from the top.
* **Numeric Display:** Show the exact evaluation (e.g., `+1.5` or `-0.3`) inside the bar.

### 4.4 Customization (Settings Modal)
* **Board Themes:** Selectable colors (Green/White, Brown/Wood, Blue/Icy).
* **Piece Sets:** Selectable styles (Neo, Classic, Alpha).

---

## 5. Functional Requirements (Backend & AI)

### 5.1 Gameplay Loop
* **Move Validation:** Frontend uses `chess.js` to prevent illegal moves sending to the server.
* **AI Turn Handling:**
    1.  Server receives FEN string.
    2.  Converts FEN to **19x8x8 Tensor**.
    3.  AI predicts move.
    4.  Server returns move string + current evaluation score.

### 5.2 Difficulty Scaling
* **Easy:** AI selects move from Top 5 candidates (Probabilistic/Temperature > 1.0).
* **Medium:** AI selects move from Top 3 candidates (Temperature = 0.5).
* **Hard:** AI always selects Top 1 move (Temperature = 0).

---

## 6. Data Model

**Users Table**
* `id`: UUID
* `username`: String
* `elo_rating`: Integer (Default 1200)

**Games Table**
* `id`: UUID
* `white_player_id`: UUID
* `black_player_id`: UUID
* `pgn_content`: Text (Complete move history)
* `result`: String (1-0, 0-1, 1/2-1/2)

---

## 7. API Specification (Internal Contracts)

### Game Endpoints
**POST /api/match/start**
* **Req:** `{ "color": "white", "difficulty": "medium" }`
* **Res:** `{ "game_id": "123", "fen": "rnbqk..." }`

**POST /api/match/move**
* **Req:** `{ "game_id": "123", "move": "e2e4" }`
* **Res:**
    ```json
    {
      "ai_move": "c7c5",
      "new_fen": "rnbqk...",
      "eval": -0.1,
      "is_mate": false
    }
    ```

---

## 8. Deliverables Checklist

### Frontend Team (React)
- [ ] **Board Component:** Fully interactive board with legal move dots.
- [ ] **Move List UI:** A scrollable list of moves that allows time-travel (clicking previous moves).
- [ ] **Evaluation Bar:** A visual component linked to the API's evaluation score.
- [ ] **Sound Engine:** Simple hook to play audio files on events.

### Backend Team (Python)
- [ ] **Tensor Converter:** The `board_to_tensor` function (19 channels).
- [ ] **Model Loader:** Script to load the trained PyTorch model (`.pt` file) into memory.
- [ ] **FastAPI Server:** Endpoints connecting the Frontend to the Model.

### AI Team
- [ ] **Dataset:** Cleaned PGNs converted to Training Tensors.
- [ ] **Trained Model:** A `.pt` file capable of playing valid chess.
