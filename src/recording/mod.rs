//! Audio recording feature for ostt.
//!
//! Provides audio capture, real-time waveform visualization, and user interaction handling
//! for the recording workflow.

pub mod audio;
pub mod ffmpeg;
pub mod ui;

pub use audio::AudioRecorder;
pub use ffmpeg::find_ffmpeg;
pub use ui::{RecordingCommand, OsttTui};
