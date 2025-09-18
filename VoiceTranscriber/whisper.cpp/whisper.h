#ifndef WHISPER_H
#define WHISPER_H

#include <stdbool.h>
#include <stdint.h>
#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif

// Opaque pointer to the whisper context
struct whisper_context;
typedef struct whisper_context whisper_context;

// Opaque pointer to the whisper state
struct whisper_state;
typedef struct whisper_state whisper_state;

// Initialize the whisper context from a file
whisper_context * whisper_init_from_file(const char * path_model);

// Free the whisper context
void whisper_free(struct whisper_context * ctx);

// Get the length of the audio in milliseconds
int whisper_pcm_get_length_ms(struct whisper_context * ctx, const float * pcmf32, int n_samples);

// Full transcription of the provided audio
int whisper_full(struct whisper_context * ctx, const float * pcmf32, int n_samples);

// Get the number of text segments in the last transcription
int whisper_full_n_segments(struct whisper_context * ctx);

// Get the text of the specified segment
const char * whisper_full_get_segment_text(struct whisper_context * ctx, int i_segment);

#ifdef __cplusplus
}
#endif

#endif // WHISPER_H