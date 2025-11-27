//! Transcription history storage and viewing.
//!
//! Manages persistent storage of all transcriptions with SQLite,
//! and provides an interactive terminal UI for browsing and selecting
//! past transcriptions.

pub mod storage;
pub mod ui;

pub use storage::{HistoryManager, TranscriptionEntry};
pub use ui::HistoryViewer;
