use sp1_derive::AlignedBorrow;
use sp1_stark::Word;
use std::mem::size_of;

use crate::operations::BabyBearWordRangeChecker;

pub const NUM_AUIPC_COLS: usize = size_of::<AuipcCols<u8>>();

#[derive(AlignedBorrow, Default, Debug, Clone, Copy)]
#[repr(C)]
pub struct AuipcCols<T> {
    /// The current program counter.
    pub pc: Word<T>,
    pub pc_range_checker: BabyBearWordRangeChecker<T>,
}
