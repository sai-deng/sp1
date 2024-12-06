#pragma once

#include "prelude.hpp"
#include "utils.hpp"

namespace sp1_core_machine_sys::bitwise {
template<class F>
__SP1_HOSTDEV__ void event_to_row(const AluEvent& event, BitwiseCols<F>& cols) {
    cols.shard = F::from_canonical_u32(event.shard);
    write_word_from_u32<F>(cols.a, event.a);
    write_word_from_u32<F>(cols.b, event.b);
    write_word_from_u32<F>(cols.c, event.c);
    cols.is_xor = F::from_bool(event.opcode == Opcode::XOR);
    cols.is_or = F::from_bool(event.opcode == Opcode::OR);
    cols.is_and = F::from_bool(event.opcode == Opcode::AND);

    // No byte lookup yet.
}
}  // namespace sp1::bitwise
