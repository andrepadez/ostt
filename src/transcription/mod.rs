//! Transcription service for audio-to-text conversion.
//!
//! This module provides support for multiple transcription providers and models through a
//! unified interface. Each provider has its own API endpoint and authentication method.
//! Currently supports OpenAI's Whisper model for high-quality speech recognition.

pub mod animation;
pub mod api;
pub mod model;
pub mod provider;

pub use animation::TranscriptionAnimation;
pub use api::{transcribe, TranscriptionConfig, TranscriptionResponse};
pub use model::TranscriptionModel;
pub use provider::TranscriptionProvider;
