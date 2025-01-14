package com.sample.android.alchemy.tab.container.mail

import android.os.Bundle
import android.view.View
import androidx.recyclerview.widget.LinearLayoutManager
import com.sample.android.alchemy.common.ui.base.BaseBindingFragment
import com.sample.android.alchemy.tab.container.databinding.AlchemySampleFragmentMailListBinding
import com.sample.android.alchemy.tab.container.mail.adapter.MailAdapter
import com.sample.android.alchemy.tab.container.mail.bean.MockData
import com.sample.android.alchemy.common.ui.utils.NotAvailableToast

class MailListFragment(private val onMailItemClickListener: MailAdapter.OnMailItemClickListener) :
    BaseBindingFragment<AlchemySampleFragmentMailListBinding>(
        AlchemySampleFragmentMailListBinding::inflate
    ) {
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        initRecyclerView()
        initFab()
    }

    private fun initRecyclerView() {
        binding.alchemySampleRecyclerView.let {
            it.layoutManager =
                LinearLayoutManager(requireContext(), LinearLayoutManager.VERTICAL, false)
            val mailAdapter = MailAdapter(requireContext(), onMailItemClickListener)
            it.adapter = mailAdapter
            mailAdapter.submitList(MockData.dataList)
        }
    }

    private fun initFab() {
        binding.createMail.setOnClickListener {
            NotAvailableToast.show(requireContext())
        }
    }
}