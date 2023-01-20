

package org.jf.dexlib2.immutable;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

import com.google.common.collect.ImmutableList;

import org.jf.dexlib2.base.BaseTryBlock;
import org.jf.dexlib2.iface.ExceptionHandler;
import org.jf.dexlib2.iface.TryBlock;
import org.jf.util.ImmutableConverter;
import org.jf.util.ImmutableUtils;

import java.util.List;

public class ImmutableTryBlock extends BaseTryBlock<ImmutableExceptionHandler> {
    protected final int startCodeAddress;
    protected final int codeUnitCount;
    @NonNull
    protected final ImmutableList<? extends ImmutableExceptionHandler> exceptionHandlers;

    public ImmutableTryBlock(int startCodeAddress,
                             int codeUnitCount,
                             @Nullable List<? extends ExceptionHandler> exceptionHandlers) {
        this.startCodeAddress = startCodeAddress;
        this.codeUnitCount = codeUnitCount;
        this.exceptionHandlers = ImmutableExceptionHandler.immutableListOf(exceptionHandlers);
    }

    public ImmutableTryBlock(int startCodeAddress,
                             int codeUnitCount,
                             @Nullable ImmutableList<? extends ImmutableExceptionHandler> exceptionHandlers) {
        this.startCodeAddress = startCodeAddress;
        this.codeUnitCount = codeUnitCount;
        this.exceptionHandlers = ImmutableUtils.nullToEmptyList(exceptionHandlers);
    }

    public static ImmutableTryBlock of(TryBlock<? extends ExceptionHandler> tryBlock) {
        if (tryBlock instanceof ImmutableTryBlock) {
            return (ImmutableTryBlock) tryBlock;
        }
        return new ImmutableTryBlock(
                tryBlock.getStartCodeAddress(),
                tryBlock.getCodeUnitCount(),
                tryBlock.getExceptionHandlers());
    }

    @Override
    public int getStartCodeAddress() {
        return startCodeAddress;
    }

    @Override
    public int getCodeUnitCount() {
        return codeUnitCount;
    }

    @NonNull
    @Override
    public ImmutableList<? extends ImmutableExceptionHandler> getExceptionHandlers() {
        return exceptionHandlers;
    }

    @NonNull
    public static ImmutableList<ImmutableTryBlock> immutableListOf(
            @Nullable List<? extends TryBlock<? extends ExceptionHandler>> list) {
        return CONVERTER.toList(list);
    }

    private static final ImmutableConverter<ImmutableTryBlock, TryBlock<? extends ExceptionHandler>> CONVERTER =
            new ImmutableConverter<ImmutableTryBlock, TryBlock<? extends ExceptionHandler>>() {
                @Override
                protected boolean isImmutable(@NonNull TryBlock item) {
                    return item instanceof ImmutableTryBlock;
                }

                @NonNull
                @Override
                protected ImmutableTryBlock makeImmutable(@NonNull TryBlock<? extends ExceptionHandler> item) {
                    return ImmutableTryBlock.of(item);
                }
            };
}
