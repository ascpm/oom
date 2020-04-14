package io.kabang.ext.memory.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import sun.misc.Unsafe;

import java.lang.reflect.Field;

@Service
@Slf4j
public class DefaultService {

    public void test() throws Throwable {
        Class unsafeClass = Class.forName("sun.misc.Unsafe");
        Field field = unsafeClass.getDeclaredField("theUnsafe");
        field.setAccessible(true);
        Unsafe unsafe = (Unsafe) field.get(null);
        log.info("Memory Allocate Start!!");
        for (; ; ) {
            unsafe.allocateMemory(1024 * 1024 * 10);
        }
    }

}
