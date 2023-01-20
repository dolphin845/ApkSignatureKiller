

package org.jf.dexlib2.immutable.instruction;

import android.support.annotation.NonNull;

import org.jf.dexlib2.Format;
import org.jf.dexlib2.Opcode;
import org.jf.dexlib2.iface.instruction.formats.Instruction31c;
import org.jf.dexlib2.iface.reference.Reference;
import org.jf.dexlib2.immutable.reference.ImmutableReference;
import org.jf.dexlib2.immutable.reference.ImmutableReferenceFactory;
import org.jf.dexlib2.util.Preconditions;

public class ImmutableInstruction31c extends ImmutableInstruction implements Instruction31c {
    public static final Format FORMAT = Format.Format31c;

    protected final int registerA;
    @NonNull
    protected final ImmutableReference reference;

    public ImmutableInstruction31c(@NonNull Opcode opcode,
                                   int registerA,
                                   @NonNull Reference reference) {
        super(opcode);
        this.registerA = Preconditions.checkByteRegister(registerA);
        this.reference = ImmutableReferenceFactory.of(opcode.referenceType, reference);
    }

    public static ImmutableInstruction31c of(Instruction31c instruction) {
        if (instruction instanceof ImmutableInstruction31c) {
            return (ImmutableInstruction31c) instruction;
        }
        return new ImmutableInstruction31c(
                instruction.getOpcode(),
                instruction.getRegisterA(),
                instruction.getReference());
    }

    @Override
    public int getRegisterA() {
        return registerA;
    }

    @NonNull
    @Override
    public ImmutableReference getReference() {
        return reference;
    }

    @Override
    public int getReferenceType() {
        return opcode.referenceType;
    }

    @Override
    public Format getFormat() {
        return FORMAT;
    }
}
